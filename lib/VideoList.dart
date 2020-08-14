import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:videos/c.dart';
import 'package:videos/home.dart';
import 'package:videos/main.dart';
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
    var thumbnailUrl,title,favorite,watched;
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
                itemBuilder: (context, index)=>VideoListItem()
              ),
              
            ],
          )
        ],
      ),
    );
  }
}