import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos/VideoList.dart';
import 'package:videos/database.dart';
import 'package:videos/main.dart';
import 'package:youtube_player/youtube_player.dart' as android;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'c.dart';

class VideoPage extends StatefulWidget{

  final Video video;
  VideoPage(this.video);
  @override
  State<StatefulWidget> createState()=>VideoPageState();
}

class VideoPageState extends State<VideoPage> with WidgetsBindingObserver{

  Video video;
  var old=false;
  YoutubePlayerController youtubeController;
  android.VideoPlayerController androidYoutubeController;
  Duration startAt=Duration(seconds: 0);
  String note='';
  ExpandableController expandableController=ExpandableController();
  FocusNode focusNode=FocusNode();
  TextEditingController textEditingController=TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    video=widget.video;
    initialiseController();
    checkIfDeviceIsOld();
    getResumePosition();
    onExpandListener();
  }

  void onExpandListener(){
    expandableController.addListener(() {
      if(expandableController.expanded){
        focusNode.requestFocus();
      }
    });
  }

  void initialiseController()async{
    youtubeController=YoutubePlayerController(initialVideoId: video.videoId);
    //await androidYoutubeController.initialize();
  }

  Future saveCurrentPosition()async {
    if(old&&androidYoutubeController==null)return;
    if((!old)&&youtubeController.value.playerState==PlayerState.unStarted)return;
    if(old&&androidYoutubeController.value.position.inSeconds==0)return;
    var currentPosition=old?androidYoutubeController.value.position.inSeconds:youtubeController.value.position.inSeconds;
    if((!old)&&youtubeController.value.playerState==PlayerState.ended)currentPosition=0;
    if(old&&androidYoutubeController.value.duration.inSeconds==androidYoutubeController.value.position.inSeconds)currentPosition=0;
    int value=await MyApp.database.rawUpdate('update $WATCHED_VIDEOS  set $REACHED_SECOND = $currentPosition where $VIDEO_ID = \'${video.videoId}\'');
    if(value==0)await MyApp.database.rawInsert('insert into $WATCHED_VIDEOS ($VIDEO_ID,$REACHED_SECOND) values (\'${video.videoId}\',$currentPosition)');
      
  }

  @override
void didChangeAppLifecycleState(AppLifecycleState state)async {
  if(state == AppLifecycleState.resumed){
    getResumePosition();
  }else if(state == AppLifecycleState.inactive||state==AppLifecycleState.detached||state==AppLifecycleState.paused){
    await saveCurrentPosition();
  }
}

@override
  Future<bool> didPopRoute() async{
    await saveCurrentPosition();
    return super.didPopRoute();
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future checkIfDeviceIsOld() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if(sdkInt<20)old=true;
    }
  }

  void getResumePosition(){
    MyApp.database.rawQuery('select * from $WATCHED_VIDEOS where $VIDEO_ID = \'${video.videoId}\'').then(
      (value){
        if(value.length>0){
         setState(() {
            startAt=Duration(seconds:int.parse(value[0][REACHED_SECOND]));
            note=value[0][NOTE];
            youtubeController.seekTo(startAt);
            if(androidYoutubeController!=null)androidYoutubeController.seekTo(startAt);
          });
        }
      }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(video.title),
      ),
      body: Column(
        children: <Widget>[
          old?android.YoutubePlayer(
            callbackController: (controller) {
              androidYoutubeController=controller;
            },
            source: video.videoId,
            context: context,
            quality: android.YoutubeQuality.MEDIUM,
            startAt: startAt,
          ):
          YoutubePlayer(
            controller: youtubeController,
          ),Container(
            child:ExpandablePanel(
                    controller: expandableController,
                    collapsed: Text(note.isEmpty?ADD_NOTE:VIEW_NOTE),
                    expanded: TextFormField(
                      focusNode: focusNode,
                      initialValue: note,
                      controller: textEditingController,
                      onChanged: (value) {
                        setState(() async{
                          note=value;
                          int v=await MyApp.database.rawUpdate('update $WATCHED_VIDEOS  set $NOTE = \'$note\' where $VIDEO_ID = \'${video.videoId}\'');
                          if(v==0) MyApp.database.rawInsert('insert into $WATCHED_VIDEOS ($VIDEO_ID,$NOTE) values (\'${video.videoId}\',\'$note\')');
                        });
                      },
                    ),
                  ),
            padding: EdgeInsets.all(HEADER_PADDING),
            color: PRIMARY_COLOR,
          )
        ],
      ),
    );
  }
}