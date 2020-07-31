import 'package:admob_flutter/admob_flutter.dart';
import 'package:catcher/catcher.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:videos/c.dart';
import 'package:videos/database.dart';

import 'home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAdMob.instance.initialize(appId: APP_ID);
  Admob.initialize(APP_ID);
  CatcherOptions debugOptions =CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(["ahmad.rajab@windowslive.com"])
  ]);
  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

class MyApp extends StatelessWidget {

  static var database;

  void configureDatabase()async{
    database = openDatabase(DATABASE_NAME, version: DATABASE_VERSION,
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

  }

  @override
  Widget build(BuildContext context) {
    configureDatabase();
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: PRIMARY_COLOR,
        brightness: brightness
      ),
      themedWidgetBuilder: (context, data) {
        return MaterialApp(
          navigatorKey: Catcher.navigatorKey,
          title: APP_NAME,
          theme: data,
          home: MyHomePage(),
        );
      },
    );
  }
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  gender: MobileAdGender.unknown,
  designedForFamilies: true,
  childDirected: true
);

class AdmobAdd extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
    return !PRO?AdmobBanner(
              adUnitId: BANNER_AD_UNIT_ID,
              adSize: AdmobBannerSize.BANNER,
              ):Container();
  }
  }

InterstitialAd myInterstitial = InterstitialAd(
  adUnitId: InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
);