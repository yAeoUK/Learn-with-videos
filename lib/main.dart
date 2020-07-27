import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:videos/c.dart';

import 'home.dart';

void main() {
  CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
      
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(["ahmad.rajab@windowslive.com"])
  ]);
  Catcher(MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

class MyApp extends StatelessWidget {

  static var database;

  }

  @override
  Widget build(BuildContext context) {
    openDatabase();
    return MaterialApp(
      navigatorKey: Catcher.navigatorKey,
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: PRIMARY_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}