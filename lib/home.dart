import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videos/VideoList.dart';
import 'package:videos/c.dart';
import 'package:videos/database.dart';
import 'package:videos/main.dart';
import 'package:videos/post.dart';
import 'home_drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  Video lastWatchedVideo;
  var lastWatchedVideoExists=false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
      .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
      showRateAppMessage();
    showLastWatchedVideo();
  }

  void showLastWatchedVideo()async{
    var preferences=await SharedPreferences.getInstance();
    if(!preferences.containsKey('lastWatchedVideo'))return;
    setState(() {
      lastWatchedVideo=Video.fromJson(json.decode(preferences.getString('lastWatchedVideo')));
      lastWatchedVideoExists=true;
    });
  }

  void showRateAppMessage()async{
    int askLater=0,never=-1,ok=1;
    var reference=await SharedPreferences.getInstance();
    if((reference.getInt('rateApp')??askLater)==askLater){
      int count=reference.getInt('count')??0;
      if(count<5)reference.setInt('count', count+1);
      else {
        reference.setInt('count', 0);
        showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext build){
                          return AlertDialog(
                            title: Text(RATE_THE_APP),
                            content: Text(PLEASE_RATE_THE_APP),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(OK),
                                onPressed:(){
                                  Navigator.pop(context);
                                  reference.setInt('rateApp', ok);
                                  launchURL(APP_LINK);
                                } ,
                              ),
                              FlatButton(
                                child: Text(ASK_LATER),
                                onPressed:(){
                                  Navigator.pop(context);
                                } ,
                              ),
                              FlatButton(
                                child: Text(NEVER),
                                onPressed:(){
                                  Navigator.pop(context);
                                  reference.setInt('rateApp', never);
                                } ,
                              )
                            ],
                          );
                        }
                      );
   
      }
    }
  }

 GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  List<Channel> channels=List<Channel>();

  Future<void> getChannelsData() async {
    await MyApp.configureDatabase();
    channels.clear();
    AppDatabase database=AppDatabase();
    List<Channel> c=await database.getAllChannels();
    channels.addAll(c);
    /*var databaseData=await MyApp.database.rawQuery('select * from $CHANNELS');
    for(int c=0;c<databaseData.length;c++){
      channels.add(
        Channel(
          name: databaseData[c][NAME],
          pictureUrl: databaseData[c][PICTURE_LINK],
          url:databaseData[c][LINK],
          viewed: databaseData[c][VIEWED]
        )
      );
    }*/
    if(channels.length>0)setState(() {
      channels=channels;
    });

    var preferences=await SharedPreferences.getInstance();
    var last=preferences.getInt('lastChannelsFitch')??0;
    var dateTime=DateTime.fromMillisecondsSinceEpoch(last).toUtc();
    var dateTimeSqlString =toSQLDateTimeString(dateTime);
    var map=Map();
    map['lastChannelsFitch']=dateTimeSqlString;

    var p=Post(context,'fitchNewChannels.php',map);
    await p.fetchPost();
    if(!p.connectionSucceed)return;
    var databaseNetworkData=p.result;
    List<dynamic> databaseNetworkJson= json.decode(databaseNetworkData);
    for(int c=0;c<databaseNetworkJson.length;c++){
      int channelId= int.parse(databaseNetworkJson[c]['id']);
      //var v=await MyApp.database.rawQuery('select * from $CHANNELS where id = $channelId');
      var v=await database.getChannelsById(channelId);
      if(v.length==0){
        Channel channel=Channel(
            name:databaseNetworkJson[c]['name'],
            pictureLink:databaseNetworkJson[c]['pictureLink'],
            link:databaseNetworkJson[c]['link'],
            type:databaseNetworkJson[c]['type'],
            viewed: 0,
            getNotifications: 1,
            id: channelId
          );
        channels.add(channel);
        //await MyApp.database.rawInsert('insert into $CHANNELS ($NAME,$LINK,$PICTURE_LINK,$ID) values (\'${channel.name}\' , \'${channel.url}\', \'${channel.pictureUrl}\',$channelId )');
        await database.insertNewChannel(channel);
      }
      else {
        /*Channel channel=Channel(
            name:databaseNetworkJson[c]['name'],
            pictureUrl:databaseNetworkJson[c]['pictureLink'],
            url:databaseNetworkJson[c]['link'],
          );*/
          // ignore: missing_required_param
          Channel channel=Channel(
            name:databaseNetworkJson[c]['name'],
            pictureLink:databaseNetworkJson[c]['pictureLink'],
            link:databaseNetworkJson[c]['link'],
            type:databaseNetworkJson[c]['type'],
            id: channelId
          );
          /*for(int c=0;c<channels.length;c++)if(channels[c].link==channel.link){
              channels[c]=channel;
              break;
          }*/
          //await MyApp.database.rawUpdate('update $CHANNELS set $NAME = \'${channel.name}\' , $LINK = \'${channel.url}\', $PICTURE_LINK = \'${channel.pictureUrl}\' where $ID = $channelId');
          await database.updateChannel(channel);
      }

    }
    preferences.setInt('lastChannelsFitch', DateTime.now().toUtc().millisecondsSinceEpoch);
    setState(() {
      channels=channels;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Column(
        children: <Widget>[
          AdmobAdd(),
          RefreshIndicator(
            onRefresh: getChannelsData,
            key: _refreshIndicatorKey,
            child:ListView(
              shrinkWrap: true,
                children: <Widget>[
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: channels.length,
                    itemBuilder:(context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => VideoListPage(channel:channels[index] ,)));
                        },
                        child: Card(
                          child: Column(
                            children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(SEPARATOR_PADDING/2.0),
                                    child: ClipOval(
                                      child:CachedNetworkImage(
                                          imageUrl:channels[index].pictureLink,
                                          fit: BoxFit.fill,
                                        ), 
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: channels[index].viewed==0?PRIMARY_COLOR:Colors.grey,
                                        width: SEPARATOR_PADDING/2
                                      ),
                                      shape: BoxShape.circle,
                                      ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(channels[index].name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),
                                        ),
                                  )
                                )
                              ],
                            )
                        ),
                      );
                      }
                    )
                ],
              )
            ,
        )
        ] 
      ),
      /*bottomNavigationBar:(!lastWatchedVideoExists)?Container(): 
      VideoListItem(context: context,video: lastWatchedVideo,),*/
    );
  }
}
