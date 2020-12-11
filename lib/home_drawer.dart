import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:videos/VideoList.dart';
import 'package:videos/c.dart';
import 'package:videos/contactUs.dart';
import 'package:videos/settings.dart';

class MainDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.star,
          color: PRIMARY_COLOR,
          ),
          title: Hero(
            child: Text(FAVORITE_VIDEOS),
            tag: FAVORITE_VIDEOS,
          ),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context) => VideoListPage(favorite:true,)));
          },
        ),
        Divider(indent: SEPARATOR_PADDING,
        endIndent: SEPARATOR_PADDING,),
        ListTile(
          leading: Icon(Icons.phone,
          color: PRIMARY_COLOR,),
          title: Text(CONTACT_US),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context) => ContactUsPage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings,
          color: PRIMARY_COLOR,),
          title: Text(SETTINGS),
          onTap: (){
            Navigator.pop(context);
            Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.star_half,
          color: PRIMARY_COLOR,),
          title: Text(RATE_THE_APP),
          onTap: (){
            Navigator.pop(context);
            launchURL(APP_LINK);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.share,
            color: PRIMARY_COLOR,
          ),
          title: Text(SHARE),
          onTap: (){
            Navigator.pop(context);
            Share.share(TRY_THE_APPLICATION);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.apps,
            color: PRIMARY_COLOR,
          ),
          title: Text(MORE_APPS),
          onTap: (){
            Navigator.pop(context);
            launchURL(DEVELOPERS_APPS);
          },
        ),
        /*ListTile(
          leading: Icon(
            Icons.info,
            color: PRIMARY_COLOR,
          ),
          title: Text(APP_INFO),
          onTap: (){
            Navigator.pop(context);
            showAboutDialog(
              context: context,
              applicationName: APP_NAME,
              applicationVersion: PackageInfo
              );
          },
        )*/
      ],
    );
  }
}