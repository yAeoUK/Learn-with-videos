import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:videos/dialogues.dart';

import 'c.dart';

class Post {
  final String url;
  final Map map;
  final BuildContext context;
  Post(this.context,this.url, this.map);

  Future<String> fetchPost() async{
  try{
    final response=await post(ROOT_URL+url,body: map);
  if (response.statusCode == 200) {
    ////dynamic jsonData=json.decode(response.body);
    return response.body;
  }
  }catch(SocketException){
    showNoConnectionDialogue(context);
    /*showDialog(context: context,builder: (BuildContext context){
        return AlertDialog(actions: <Widget>[
          FlatButton(
            child: Text(OK),
            onPressed:(){
              Navigator.pop(context);
            } 
          )
        ],title: Text(ERROR),content: SingleChildScrollView(child: Padding(padding:EdgeInsets.all(10.0) ,child:Row(children: <Widget>[Padding(padding:EdgeInsets.all(10.0) ,),Text(
          PLEASE_TRY_AGAIN_LATER
        )
        ],
        )
        )
        )
        );
    
  });
*/}
return '';
}
}