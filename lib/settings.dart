import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'c.dart';

class SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SETTINGS),
      ),
    );
  }
}