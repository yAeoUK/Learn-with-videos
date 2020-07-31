import 'package:flutter/material.dart';
import 'package:videos/c.dart';

import 'home_drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
    );
  }
}
