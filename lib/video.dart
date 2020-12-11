import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart' as database;
import 'package:videos/VideoList.dart';
import 'package:videos/main.dart';
import 'package:youtube_player/youtube_player.dart' as android;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'c.dart';
import 'database/database.dart';
import 'post.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:http/http.dart';


class VideoPageRoute extends Page {
  final String videoId;

  VideoPageRoute({
    this.videoId,
  }) : super(key: ValueKey(videoId));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return VideoPage(videoId: videoId);
      },
    );
  }
}

class VideoPage extends StatefulWidget{

  final Video video;
  final String videoId;
  VideoPage({this.video,this.videoId});
  @override
  State<StatefulWidget> createState()=>VideoPageState();
}

class VideoPageState extends State<VideoPage> with WidgetsBindingObserver{

  Video video;
  WatchedVideo watchedVideoData;
  bool videoLoadedFromDatabase=false;
  var old=false;
  YoutubePlayerController youtubeController;
  android.VideoPlayerController androidYoutubeController;
  Duration startAt=Duration(seconds: 0);
  String note='';
  ExpandableController expandableController=ExpandableController();
  FocusNode focusNode=FocusNode();
  TextEditingController textEditingController=TextEditingController();
  var description='';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    video=widget.video;
    initialiseController();
    checkIfDeviceIsOld();
    getResumePosition();
    onExpandListener();
    showInterstitialWhenPausedOrFinished();
    //getVideoData();
  }

  void getVideoData(){
    var m=Map<String,String>();
    m['videoId']=video.videoId;
    var p=Post(context,'getVideoData.php',m);
    if(!p.connectionSucceed)return;
    var resultJson=json.decode(p.result);
    if(resultJson['result']=='succeed'&&resultJson['message']=='Needs update'){
      
      getVideoData();
      return;
    }
  }

  void showInterstitial()async{
    InterstitialAd myInterstitial = InterstitialAd(adUnitId: kReleaseMode?INTERSITIAL_AD_UNIT_ID:InterstitialAd.testAdUnitId,targetingInfo: targetingInfo);
    if(!PRO){
      await myInterstitial.load();
      await myInterstitial.show();
    }
  }

  void showInterstitialWhenPausedOrFinished(){
    if(old)androidYoutubeController.addListener(() {
      if(!androidYoutubeController.value.isPlaying){
        showInterstitial();
        return;
      }
    });
    if(!old)youtubeController.addListener(() {
      if(youtubeController.value.playerState==PlayerState.paused||youtubeController.value.playerState==PlayerState.ended){
        showInterstitial();
      }
     });
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

  Future saveCurrentPosition({bool close=false})async {
    if(old&&androidYoutubeController==null){
      if(close)Navigator.pop(context);
      return;
    }
    //if((!old)&&youtubeController.value.playerState==PlayerState.unStarted)return;
    //if(old&&androidYoutubeController.value.position.inSeconds==0)return;
    int seconds=0;
    seconds=old?androidYoutubeController.value.position.inSeconds:youtubeController.value.position.inSeconds;
    if((!old)&&youtubeController.value.playerState==PlayerState.ended)seconds=-1;//startAt=Duration();
    if(old&&androidYoutubeController.value.duration.inSeconds==androidYoutubeController.value.position.inSeconds)seconds=-1;//startAt=Duration();
    Database d=RepositoryProvider.of<Database>(context);
    // RepositoryProvider.of<Database>(context).addOrUpdateWatchedVideo(
    //   WatchedVideosCompanion(
    //     videoId:database.Value(video.videoId),
    //     note: database.Value(note),
    //     reachedSecond: database.Value(seconds),//database.Value(startAt.inSeconds),
    //     videoThumbURL: database.Value(video.thumbnailUrl),
    //     videoTitle: database.Value(video.title),
    //     id: watchedVideoData!=null?watchedVideoData.id:database.Value.absent()
    //   )
    // );
    if(videoLoadedFromDatabase)d.update(d.watchedVideos).replace(WatchedVideosCompanion(
        videoId:database.Value(video.videoId),
        note: database.Value(note),
        reachedSecond: database.Value(seconds),//database.Value(startAt.inSeconds),
        videoThumbURL: database.Value(video.thumbnailUrl),
        videoTitle: database.Value(video.title),
        id: database.Value(watchedVideoData.id)
      ));
    else {
      d.into(d.watchedVideos).insert(
    WatchedVideosCompanion(videoId:database.Value(video.videoId),
                            note:database.Value(note), 
                            reachedSecond:database.Value(seconds),
                            videoTitle:database.Value(video.title),
                            videoThumbURL:database.Value(video.thumbnailUrl),
                            ),);
      videoLoadedFromDatabase=true;
      getResumePosition();
    }
    if(close)Navigator.pop(context);
    //int value=await MyApp.database.rawUpdate('update $WATCHED_VIDEOS  set $REACHED_SECOND = $currentPosition where $VIDEO_ID = \'${video.videoId}\'');
    //if(value==0)await MyApp.database.rawInsert('insert into $WATCHED_VIDEOS ($VIDEO_ID,$REACHED_SECOND) values (\'${video.videoId}\',$currentPosition)');
      
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {
    if(state == AppLifecycleState.resumed){
      getResumePosition();
    }else if(state == AppLifecycleState.inactive||state==AppLifecycleState.detached||state==AppLifecycleState.paused){
      saveCurrentPosition();
    }
}

/*@override
  Future<bool> didPopRoute() async{
    await saveCurrentPosition();
    return super.didPopRoute();
  }*/

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

  void getResumePosition()async{
    List<WatchedVideo> watchedVideos=await RepositoryProvider.of<Database>(context).getWatchedVideosById(video.videoId);
    if(watchedVideos.isNotEmpty){
      videoLoadedFromDatabase=true;
      setState(() {
      watchedVideoData=watchedVideos[0];
      note=watchedVideoData.note;
      startAt=Duration(seconds: watchedVideoData.reachedSecond);
      textEditingController.value=TextEditingValue(text: watchedVideoData.note);
      if(old)androidYoutubeController.seekTo(startAt);
      else youtubeController.seekTo(startAt);
      });
    }
    /*MyApp.database.rawQuery('select * from $WATCHED_VIDEOS where $VIDEO_ID = \'${video.videoId}\'').then(
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
      );*/
  }

  Future<void> fetchVideo(String videoId)async{
    Response response;
    
      response= await get('https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$YOUTUBEAPIKey');
      if(response.statusCode==200){
        dynamic responseJson=json.decode(response.body);
        //int totalResults=responseJson['pageInfo']['totalResults'];
        List<dynamic> itemsJson=responseJson['items'];
        List<V> videos= List<V>();
        for(int c=0;c<itemsJson.length;c++){
          videos.add(
          V(itemsJson[c]['snippet']['publishedAt'],
                          itemsJson[c]['snippet']['channelId'],
                          itemsJson[c]['snippet']['title'],
                          itemsJson[c]['snippet']['thumbnails']['default']['url'],
                          itemsJson[c]['id'],
                          description: itemsJson[c]['snippet']['desciption']
                          ));
        }
        var m=Map();
        m['videos']=videos;
        String encodedVideos=json.encode(m);
        Map<String,String> map=Map<String,String>();
        map['videos']=encodedVideos;
        response=await post(ROOT_URL+'uploadVideoData.php',body:map);
    }
  }

  bool loading=true;
  Future loadData(BuildContext context)async{
    if(!loading)return;
    var map=Map();
                  map['videoId']=video.videoId;
                  Post p=Post(context,'getVideoData.php',map);
                  await p.fetchPost();
                  if(!p.connectionSucceed)return;
                  var dataString=p.result;
                  var dataJSON= json.decode(dataString);
                  if(dataJSON['result']=='success'&&dataJSON['message']=='Needs update'){
                    await fetchVideo(video.videoId);
                    loadData(context);
                    return;
                  }
                  for(var c=0;c<dataJSON['data'].length;c++){
                    var videoJSON=dataJSON['data'][c];
                    var video=Video(
                        title: videoJSON['title'],
                        thumbnailUrl: videoJSON['thumbnailUrl'],
                        videoId: videoJSON['videoId'],
                        description: videoJSON['description']
                      );
                    //var temp=await MyApp.database.rawQuery('select * from $TABLE_FAVORITE_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    List<FavoriteVideo> temp=await RepositoryProvider.of<Database>(context).getFavoriteVideosById(video.videoId);
                    video.favorite=(temp.length==1);
                    List<WatchedVideo>tem =await RepositoryProvider.of<Database>(context).getWatchedVideosById(video.videoId);
                    //temp=await MyApp.database.rawQuery('select * from $WATCHED_VIDEOS where $VIDEO_ID = \'${video.videoId}\'');
                    if(tem.length==0)video.watched=Watched.notWatched;
                    else if(tem[0].reachedSecond==-1)video.watched=Watched.watched;
                    else video.watched=Watched.notCompleted;
                  }
                  setState(() {
                    loading=false;
                    description=video.description;
                  });
  }
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(context),
      builder: (cont,snapshot)=>Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: video.title,
            child: Text(video.title),
          ),
        ),
        body: Column(
          children: <Widget>[
            AdmobAdd(),
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
              onReady: (){
                youtubeController.seekTo(startAt);
              },
            ),Container(
              child:ExpandablePanel(
                      controller: expandableController,
                      header: Text(
                        note.isEmpty?ADD_NOTE:VIEW_NOTE,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      expanded:PRO? Container(
                        color: Colors.white,
                        child: TextFormField(
                        minLines: 5,
                        maxLines: 10,
                        focusNode: focusNode,
                        controller: textEditingController,
                        onChanged: (value) {
                          setState(() async{
                            note=value;
                            saveCurrentPosition();
                            //int v=await MyApp.database.rawUpdate('update $WATCHED_VIDEOS  set $NOTE = \'$note\' where $VIDEO_ID = \'${video.videoId}\'');
                            //if(v==0) MyApp.database.rawInsert('insert into $WATCHED_VIDEOS ($VIDEO_ID,$NOTE) values (\'${video.videoId}\',\'$note\')');
                          });
                        },
                      ),
                      ):RaisedButton(
                        child: Text(PREMIUM_FEATURE),
                        onPressed: (){
                          launchURL(APP_LINK+'.pro');
                        },
                      ),
                    ),
              padding: EdgeInsets.all(HEADER_PADDING),
              color: PRIMARY_COLOR,
            ),
            Linkify(
              text:description,
              onOpen:(url)=>launchURL(url.url)
            )
          ],
        ),
      )
    );
  }
}