import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:videos/dialogues.dart';
import 'c.dart';

class Post {
  final String url;
  final Map map;
  final BuildContext context;
  String result;
  bool connectionSucceed=false;
  bool showDialogue;
  Post(this.context,this.url, this.map,{this.showDialogue=false});

  Future fetchPost() async{
  try{
    if(showDialogue)showLoadingDialogue(context);
    
    final response=await post(ROOT_URL+url,body: map,headers: {
  "Access-Control-Allow-Origin": "*", // Required for CORS support to work
  "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
  "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token",
  "Access-Control-Allow-Methods": "POST, OPTIONS"
},);
    if(showDialogue)Navigator.pop(context);
  if (response.statusCode == 200) {
    ////dynamic jsonData=json.decode(response.body);
    connectionSucceed=true;
    result= response.body;
  }
  }catch(e){
    if(showDialogue)Navigator.pop(context);
    connectionSucceed=false;
    showOKDialogue('title', e.toString(), context);
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
}
}