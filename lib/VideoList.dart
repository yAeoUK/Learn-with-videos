import 'package:flutter/cupertino.dart';
import 'package:videos/home.dart';

// ignore: must_be_immutable
class VideoListPage extends StatefulWidget{
  var favorite=false;
  Channel channel;
  VideoListPage({this.favorite,this.channel});
  @override
  State<StatefulWidget> createState()=>VideoListPageState();
  }
  
  class VideoListPageState extends State<VideoListPage>{
    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}