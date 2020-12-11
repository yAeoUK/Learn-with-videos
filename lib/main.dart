import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:catcher/catcher.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:videos/c.dart';
import 'package:flutter/foundation.dart';
import 'package:videos/post.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'database/database.dart';
import 'database/database/mobile.dart' as mobile;
import 'src/app_route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: APP_ID);
  Admob.initialize(APP_ID);
  await AndroidAlarmManager.initialize();

  CatcherOptions debugOptions =CatcherOptions(DialogReportMode(), [kIsWeb?ConsoleHandler(): EmailManualHandler(["ahmad.rajab@windowslive.com"])]);
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    kIsWeb?ToastHandler():EmailManualHandler(["ahmad.rajab@windowslive.com"])
  ]);
  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>MyAppState();
}

class MyAppState extends State<MyApp> {

  static Future configureDatabase()async{
    /*database = await openDatabase(DATABASE_NAME, version: DATABASE_VERSION,
    onCreate: (Database db, int version) async {
      await db.execute('create table $WATCHED_VIDEOS ($VIDEO_ID text,$REACHED_SECOND integer default 0,$NOTE text)');
      await db.execute('create table $TABLE_FAVORITE_VIDEOS ($VIDEO_TITLE text,$VIDEO_ID text,$VIDEO_DESCRIPTION text,$VIDEO_THUMBURL text)');
      await db.execute('create table $CHANNELS ($ID integer ,$NAME text,$LINK text, $PICTURE_LINK text,$VIEWED integer default 0,$GET_NOTIFICATIONS integer default 1,$LAST_VIDEO_TITLE text)');
     },
     onUpgrade: (db, oldVersion, newVersion)async {
       var tableColumns= await db.query('PRAGMA table_info($WATCHED_VIDEOS)');
       bool noteColumnExists=false;
       for(int c=0;c<tableColumns.length;c++){
         if(tableColumns[c]['name'].toString()==NOTE)noteColumnExists=true;
       }
       if(!noteColumnExists) await db.execute('alter table $WATCHED_VIDEOS add $NOTE text');
     },);
    */
  }

  AppRouterDelegate _routerDelegate = AppRouterDelegate();
  AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  void initState() {
    super.initState();
    initialiseNotification();
    initialiseTimeZone();
    showDailyReminderNotification();
    configureDailyNewVideosFitch();
  }

  void configureDailyNewVideosFitch()async{
      await AndroidAlarmManager.periodic(const Duration(days: 1),DAILY_NEW_VIDEOS_FETCH_ALARAM_ID , ()async{
        Database d=RepositoryProvider.of<Database>(context);
        List<Channel>subscribedChannels=await (d.select($ChannelsTable(d))..where((tbl) => tbl.getNotifications.equals(1))).get();
        String channelsIds='';
        for(int i=0;i<subscribedChannels.length;i++)channelsIds+=subscribedChannels[i].link+"/";
        Map<String,String> map=Map();
        map['channels']=channelsIds;
        Post p=Post(context,'getVideosFromTime.php',map);
        await p.fetchPost();
        if(p.connectionSucceed){
          dynamic resultJson=json.decode(p.result);
          if(resultJson['result']=='success'){
            for(int i=0;i<resultJson['data'].length;i++){
              dynamic videoJson=resultJson['data'][i];
              await flutterLocalNotificationsPlugin.show(videoJson['id'], videoJson['channelName'], videoJson['title'],
               NotificationDetails(
                 android: AndroidNotificationDetails(
                   APP_NAME,
                   APP_NAME, NEW_VIDEO_AVAILABLE,
                   icon: '@mipmap/ic_launcher',
                   ticker: videoJson['title']
               ),
              ),
              payload:'/watch?v='+videoJson['videoId']
             );
            }
          }
        }
      },rescheduleOnReboot: true);

  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void showDailyReminderNotification()async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(APP_NAME,
            APP_NAME, 'dailyReminder'+APP_NAME,
            icon: '@mipmap/ic_launcher',
            ticker: TIME_TO_LEARN);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(DAILY_REMINDER_NOTIFICATION_ID, TIME_TO_LEARN,
        TIME_TO_LEARN_DESCRIPTION, RepeatInterval.daily, platformChannelSpecifics,
        androidAllowWhileIdle: false);
  }

  void initialiseTimeZone()async{
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));
  }

  void initialiseNotification()async{
   flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          /*onDidReceiveLocalNotification: onDidReceiveLocalNotification*/);
  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
  await flutterLocalNotificationsPlugin.cancel(DAILY_REMINDER_NOTIFICATION_ID);
}

Future selectNotification(String payload) async {
    if(payload!=null)Navigator.pushNamed(context, payload);
}

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) => ThemeData(
            primarySwatch: PRIMARY_COLOR,
            brightness: brightness
          ),
          themedWidgetBuilder: (context, data) {
     return RepositoryProvider<Database>(
      create:(context)=>mobile.constructDb() ,
      child: BlocProvider(
        create: (context){
          //final db = RepositoryProvider.of<Database>(context);
          //return AppBloc(db);
        },
        child: MaterialApp.router(
              //title: 'Books App',
              theme: data,
              routerDelegate: _routerDelegate,
              routeInformationParser: _routeInformationParser,
        )
      )
     );
    }
  );
}
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  // ignore: deprecated_member_use
  gender: MobileAdGender.unknown,
  childDirected: true
);

class AdmobAdd extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return !PRO?AdmobBanner(
              adUnitId: kReleaseMode?BANNER_AD_UNIT_ID:BannerAd.testAdUnitId,
              adSize: AdmobBannerSize.BANNER,
              ):Container();
  }
  }

InterstitialAd myInterstitial = InterstitialAd(
  adUnitId: InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
);