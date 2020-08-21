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
  Post(this.context,this.url, this.map);

  Future fetchPost() async{
  try{
    final response=await post(ROOT_URL+url,body: map);
  if (response.statusCode == 200) {
    ////dynamic jsonData=json.decode(response.body);
    connectionSucceed=true;
    result= response.body;
  }
  }catch(SocketException){
    connectionSucceed=false;
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
}
}