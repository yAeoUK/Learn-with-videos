import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:admob_flutter/admob_flutter.dart';


   const String Last_Channels_Fitch= 'lastChannelsFitch';
   const String NOTIFY_NEW_CHANNEL='notifyNewChannel';
   const String DATABASE_NAME='my_db.db';
   const int DATABASE_VERSION=2;
   Database database;

   const ROOT_URL='http://learnspanishenglish.atwebpages.com'+'//';
   const APP_NAME='Learn Spanish';
   const FAVORITE_VIDEOS='Favorite videos';
   const SETTINGS='Settings';
   const RATE_THE_APP='Rate the app';
   const SHARE='Share';
   const MORE_APPS='More apps';
   const TRY_THE_APPLICATION='Try learning Spanish with videos app https://play.google.com/store/apps/details?id=com.atwebpages.learnspanishenglish';
   const NOTIFICATIONS='Notifications';
   const NOTIFY_WHEN_NEW_CHANNELS_ARE_AVAILABELE='Notify when new channels are available';
   const NEW_CHANNEL='New channel';
   const NEW_CHANNEL_IS_AVAILABLE='New channel is available';
   const CLICK_TO_BROWSE_NEW_CHANNELS='Click to browse new channels';
   const APP_ID='ca-app-pub-8041962973846499~6919729392';
   const BANNER_AD_UNIT_ID='ca-app-pub-8041962973846499/9270560565';
   //const BANNER_AD_UNIT_ID='ca-app-pub-3940256099942544/6300978111';

  const color=Color.fromRGBO(255, 196, 0, 1.0);
   const PRIMARY_COLOR=MaterialColor(
  _PrimaryValue,
  <int, Color>{
    50: color,
    100: color,
    200: color,
    300: color,
    400: color,
    500: Color(_PrimaryValue),
    600: color,
    700: color,
    800: color,
    900: color,
  },
);
  const _PrimaryValue = 0xFFFFC400;
   const LIGHT_PRIMARY_COLOR=Colors.yellow;
   const DEVELOPERS_APPS='https://play.google.com/store/apps/developer?id=Ahmed+Rajab';
   const HEADER_PADDING=10.0;
   const SEPARATOR_PADDING=10.0;
   const NEW_VIDEO_AVAILABLE='A new video is available';
   const YOUTUBEAPIKey='AIzaSyDGefv0OK9k95NkhRD-HtfBseUMIoLlLY0';
   const LOAD_MORE='Load more';
   const CONTACT_US='Contact us';
   const ENTER_QUESTION_OR_SUGGESION_BELOW='Enter your question or suggesion below';
   const OK='OK';
   const PLEASE_WAIT='Please wait';
   const UPLOADLING_DATA='Uploading data';
   const THANKS='Thanks';
   const DATA_RECEIVED_THANKS='Data is received, thanks for contributing in making the app better';
   const ERROR='Error';
   const PLEASE_TRY_AGAIN_LATER='Please try again later';
   const PRO=true;

   String doubleDigit(int digit){
    if(digit<10)return '0'+digit.toString();
    return digit.toString();
  }

   String toSQLDateTimeString(DateTime dateTime){
    return '${dateTime.year}-${doubleDigit(dateTime.month)}-${doubleDigit(dateTime.day)} ${doubleDigit(dateTime.hour)}:${doubleDigit(dateTime.minute)}:${doubleDigit(dateTime.second)}';
    
  }

   void launchURL(String url)async{
    if(await canLaunch(url))await launch(url);
    else throw('can not launch url');
  }
