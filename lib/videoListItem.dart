import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos/VideoList.dart';
import 'package:videos/database.dart';
import 'package:videos/main.dart';
import 'package:videos/video.dart';

import 'c.dart';

class VideoListItem extends StatefulWidget{

  final Video video;
  final context;
  VideoListItem({this.video,this.context});
  @override
  State<StatefulWidget> createState()=>VideoListItemState();
}

class VideoListItemState extends State<VideoListItem>{

  Video video;var context;
  @override
  void initState() {
    super.initState();
    video=widget.video;
    context=widget.context;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
                      border: Border.all(
                        color: video.watched==Watched.notWatched?PRIMARY_COLOR:
                              video.watched==Watched.notCompleted?LIGHT_PRIMARY_COLOR:
                              Colors.grey,
                        width: SEPARATOR_PADDING/2
                      ),
                      shape: BoxShape.rectangle,
                      ),
        child: ListTile(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => VideoPage(video)));
          },
          leading: CachedNetworkImage(
            imageUrl: video.thumbnailUrl,
          ),
          title: Text(video.title),
          trailing: GestureDetector(
            child: Icon(Icons.star,
                      color: (video.favorite?Colors.yellow:Theme.of(context).iconTheme),
                      ),
            onTap: (){
              setState(() {
                video.favorite=!video.favorite;
              });
              if(video.favorite)MyApp.database.rawInsert('insert into $TABLE_FAVORITE_VIDEOS ($VIDEO_ID,$VIDEO_TITLE,$VIDEO_THUMBURL) values (\'${video.videoId}\',\'${video.title}\',\'${video.thumbnailUrl}\')');
              else MyApp.database.rawDelete('delete from $TABLE_FAVORITE_VIDEOS where $VIDEO_ID =\'${video.videoId}\'');
            },
          )
        ),
      ),
    );
  }
}