import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos/VideoList.dart';

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
      ),
    );
  }
}