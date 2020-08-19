import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos/c.dart';
import 'package:videos/database.dart';
import 'package:videos/home.dart';
import 'package:videos/loadMore.dart';
import 'package:videos/main.dart';
import 'package:videos/post.dart';
import 'package:videos/videoListItem.dart';

// ignore: must_be_immutable
class VideoListPage extends StatefulWidget{
  var favorite=false;
  Channel channel;
  VideoListPage({this.favorite,this.channel});
  @override
  State<StatefulWidget> createState()=>VideoListPageState();
  }

  class Video{
    final thumbnailUrl,title,videoId;
    var favorite,watched;
    Video({this.videoId,this.title,this.thumbnailUrl,this.favorite,this.watched});
  }

  enum Watched{watched,notWatched,notCompleted}

  class VideoListPageState extends State<VideoListPage>{
    var favorite;
    Channel channel;
    List<Video> videos=List<Video>();
    @override
  void initState() {
    super.initState();
    favorite=widget.favorite;
    channel=widget.channel;
    configureFavorite();
  }

  void configureFavorite()async{
    if(favorite){
      var favoriteVideos=await MyApp.database.rawQuery('select * from $TABLE_FAVORITE_VIDEOS');
      for(var c=0;c<favoriteVideos.length;c++){
        var favoriteVideo=favoriteVideos[c];
                    var video=Video(
                        title: favoriteVideo[VIDEO_TITLE],
                        thumbnailUrl: favoriteVideo[VIDEO_THUMBURL],
                        videoId: favoriteVideo[VIDEO_ID],
                        favorite: true
                      );
                    var temp=await MyApp.database.rawQuery('select * from $WATCHED_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    if(temp.length==0)video.watched=Watched.notWatched;
                    else if(temp[0][REACHED_SECOND]=='0')video.watched=Watched.watched;
                    else video.watched=Watched.notCompleted;
                    videos.add(video);
      }
      setState(() {
        
      });
    }
  }

  void loadData(BuildContext context)async{
    var map=Map();
                  map['channelId']=channel.url;
                  map['skip']=videos.length;
                  var dataString=await Post(context,'getVideos.php',map).fetchPost();
                  var dataJSON= json.decode(dataString);
                  for(var c=0;c<dataJSON.length;c++){
                    var videoJSON=dataJSON[c];
                    var video=Video(
                        title: videoJSON['title'],
                        thumbnailUrl: videoJSON['thumbnailUrl'],
                        videoId: videoJSON['videoId']
                      );
                    var temp=await MyApp.database.rawQuery('select * from $TABLE_FAVORITE_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    video.favorite=(temp.length==1);
                    temp=await MyApp.database.rawQuery('select * from $WATCHED_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    if(temp.length==0)video.watched=Watched.notWatched;
                    else if(temp[0][REACHED_SECOND]=='0')video.watched=Watched.watched;
                    else video.watched=Watched.notCompleted;
                    videos.add(video);
                  }
                  setState(() {
                    
                  });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favorite?FAVORITE_VIDEOS:channel.name),
      ),
      body: Column(
        children: <Widget>[
          AdmobAdd(),
          ListView(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (context, index)=>VideoListItem(context:context,video:videos[index])
              ),
              (!favorite)?LoadMore(
                loading: true,
                onClick: ()async{
                  if(PRO)loadData(context);
                  else {
                  await RewardedVideoAd.instance.load(adUnitId:REWARD_AD_UNIT_ID ,targetingInfo: targetingInfo);
                  await RewardedVideoAd.instance.show();
                  loadData(context);
                }
                }
              ):Container()
            ],
          )
        ],
      ),
    );
  }
}