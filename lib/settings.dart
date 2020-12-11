import 'package:dynamic_theme/dynamic_theme.dart';
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
      body:SingleChildScrollView(
        child: Column(
          //shrinkWrap: true,
          children: <Widget>[
            ListTile(
                leading:Container(
                  child:Icon(Icons.wb_sunny),
                  width: 25,
                  height: 25,
                ),
                title: Text(THEME),
              ),
            DropdownButton(
              value: Theme.of(context).brightness==Brightness.light?LIGHT:NIGHT,
              underline: Divider(
                height: 2,
                color: PRIMARY_COLOR,
              ),
              onChanged: (String newValue){
                setState(() {
                  DynamicTheme.of(context).setBrightness(newValue==LIGHT?Brightness.light:Brightness.dark);
                });
              }, 
              items: <String>[LIGHT,NIGHT]
              .map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child:Text(value)/* ListTile(
                    title: Text(value),
                  ),*/
                );
              }).toList()
            )
          ],
        ),
      )
    );
  }
}