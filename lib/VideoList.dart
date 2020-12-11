import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos/c.dart';
import 'package:videos/main.dart';
import 'package:videos/post.dart';
import 'package:videos/videoListItem.dart';
import 'package:http/http.dart';

import 'database/database.dart';


class VideoListPage extends StatefulWidget{
  final bool favorite;
  final Channel channel;
  VideoListPage({this.favorite=false,this.channel});
  @override
  State<StatefulWidget> createState()=>VideoListPageState();
  }

  class V extends Object{
    String publishedAt,channelId,title,description,thumbnailUrl,videoId;
    V(this.publishedAt,this.channelId,this.title,this.thumbnailUrl,this.videoId,{this.description});
    Map toJson() => {'publishedAt':publishedAt,'channelId':channelId,'title':title,'description':description,'thumbnailUrl':thumbnailUrl,'videoId':videoId};
}

  class Video extends Object{
    final String thumbnailUrl,title,videoId,description;
    bool favorite;Watched watched;
    Video({this.videoId,this.title,this.thumbnailUrl,this.favorite,this.watched,this.description=''});

    Map toJson() => {'videoId':videoId,'title':title,'thumbnailUrl':thumbnailUrl,'favorite':favorite,'watched':watched.toString(),'description':description};
    
    factory Video.fromJson(var json){
      return Video(
        videoId: json['videoId'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'],
        favorite: json['favorite'],
        watched: json['watched']
      );
    }
  }

  enum Watched{watched,notWatched,notCompleted}

  class VideoListPageState extends State<VideoListPage>{
    bool favorite;
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
      //var favoriteVideos=await MyApp.database.rawQuery('select * from $TABLE_FAVORITE_VIDEOS');
      List<FavoriteVideo> favoriteVideos=await RepositoryProvider.of<Database>(context).getAllFavoriteVideos();
      for(var c=0;c<favoriteVideos.length;c++){
        var favoriteVideo=favoriteVideos[c];
                    var video=Video(
                        title: favoriteVideo.videoTitle,//[VIDEO_TITLE],
                        thumbnailUrl: favoriteVideo.videoThumbURL,//[VIDEO_THUMBURL],
                        videoId: favoriteVideo.videoId,//[VIDEO_ID],
                        favorite: true
                      );
                    //var temp=await MyApp.database.rawQuery('select * from $WATCHED_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    var temp =await RepositoryProvider.of<Database>(context).getWatchedVideosById(video.videoId);
                    if(temp.length==0)video.watched=Watched.notWatched;
                    else if(temp[0].reachedSecond==-1)video.watched=Watched.watched;
                    else video.watched=Watched.notCompleted;
                    videos.add(video);
      }
      setState(() {
        
      });
    }
  }

  Future<void> fetchVideos(String channelId,{String nextPageToken=''})async{
    Response response;
    
      response= await get('https://www.googleapis.com/youtube/v3/search?channelId=$channelId&part=snippet&key=$YOUTUBEAPIKey&order=date&pageToken=$nextPageToken&maxResults=50');
    if(response.statusCode==200){
      dynamic responseJson=json.decode(response.body);
      nextPageToken=responseJson['nextPageToken'];
      //int totalResults=responseJson['pageInfo']['totalResults'];
      List<dynamic> itemsJson=responseJson['items'];
      List<V> videos= List<V>();
      for(int c=0;c<itemsJson.length;c++){
        videos.add(
        V(itemsJson[c]['snippet']['publishedAt'],
                        itemsJson[c]['snippet']['channelId'],
                        itemsJson[c]['snippet']['title'],
                        itemsJson[c]['snippet']['thumbnails']['default']['url'],
                        itemsJson[c]['id']['videoId']
                        ));
      }
      var m=Map();
      m['videos']=videos;
      String encodedVideos=json.encode(m);
      Map<String,String> map=Map<String,String>();
      map['videos']=encodedVideos;
      response=await post(ROOT_URL+'uploadVideosData.php',body:map);
  }
  }


  Future loadData(BuildContext context)async{
    if(!loading)return;
    var map=Map();
                  map['channelId']=channel.link;
                  map['skip']=videos.length.toString();
                  Post p=Post(context,'getVideos.php',map);
                  await p.fetchPost();
                  if(!p.connectionSucceed)return;
                  var dataString=p.result;
                  var dataJSON= json.decode(dataString);
                  if(dataJSON['result']=='success'&&dataJSON['message']=='Needs update'){
                    await fetchVideos(channel.link);
                    loadData(context);
                    return;
                  }
                  for(var c=0;c<dataJSON['data'].length;c++){
                    var videoJSON=dataJSON['data'][c];
                    var video=Video(
                        title: videoJSON['title'],
                        thumbnailUrl: videoJSON['thumbnailUrl'],
                        videoId: videoJSON['videoId']
                      );
                    //var temp=await MyApp.database.rawQuery('select * from $TABLE_FAVORITE_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    List<FavoriteVideo> temp=await RepositoryProvider.of<Database>(context).getFavoriteVideosById(video.videoId);
                    video.favorite=(temp.length==1);
                    List<WatchedVideo>tem =await RepositoryProvider.of<Database>(context).getWatchedVideosById(video.videoId);
                    //temp=await MyApp.database.rawQuery('select * from $WATCHED_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    if(tem.length==0)video.watched=Watched.notWatched;
                    else if(tem[0].reachedSecond==-1)video.watched=Watched.watched;
                    else video.watched=Watched.notCompleted;
                    videos.add(video);
                  }
                  setState(() {
                    loading=false;
                  });
  }
  bool loading=true;

    @override
  Widget build(BuildContext context) {
        return FutureBuilder(
          future:loadData(context),
          builder: (cont,snapshot)=>Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Hero(
                    tag: favorite?FAVORITE_VIDEOS:channel.name,
                    child: Text(favorite?FAVORITE_VIDEOS:channel.name),
                  ),
                  expandedHeight: 200,
                  floating: true,
                  snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: channel.pictureLink,
                      child: CachedNetworkImage(
                        imageUrl:channel.pictureLink,
                        fit: BoxFit.fill,
                        placeholder:(context,text)=> Center(
                          child: CircularProgressIndicator(),
                        )
                      ),
                    )
                  ),
                ),
                SliverList(
                  delegate:SliverChildListDelegate(
                    [
                      AdmobAdd()
                    ]
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index)=>VideoListItem(context:context,video:videos[index]),
                    childCount: videos.length
                  ),
                ),
                // SliverAnimatedList(
                //   initialItemCount: videos.length,
                //   itemBuilder: (context, index,animation)=>SizeTransition(
                //     sizeFactor: animation,
                //     child: VideoListItem(context:context,video:videos[index]),
                //   )
                // ),
                SliverList(
                  delegate:SliverChildListDelegate(
                    [
                      (!favorite)?
                        Center(
                          child:loading?CircularProgressIndicator():
                            RaisedButton(
                              onPressed: ()async{
                                if(!PRO) {
                                await RewardedVideoAd.instance.load(adUnitId:kReleaseMode?REWARD_AD_UNIT_ID:RewardedVideoAd.testAdUnitId ,targetingInfo: targetingInfo);
                                await RewardedVideoAd.instance.show();
                                }
                                setState(() {
                                  loading=true;
                                });
                              },
                              child: Text(LOAD_MORE),
                              color: PRIMARY_COLOR,
                            ),
                        ):Container()
                    ]
                  ),
                ),
              ],
            ),
            /*body: ListView(
              shrinkWrap: true,
              children: <Widget>[
                AdmobAdd(),
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
                        await RewardedVideoAd.instance.load(adUnitId:kReleaseMode?REWARD_AD_UNIT_ID:RewardedVideoAd.testAdUnitId ,targetingInfo: targetingInfo);
                        await RewardedVideoAd.instance.show();
                        loadData(context);
                      }
                      }
                    ):Container()
                  ],
                )
        */)
            ,
        );
      }
    }

  