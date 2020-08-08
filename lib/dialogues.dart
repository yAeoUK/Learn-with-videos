import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'c.dart';

void showOKDialogue(String title,String content,BuildContext context,{void onOkClicked()}){
     showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext build){
                          return AlertDialog(
                            title: Text(title),
                            content: Text(content),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(OK),
                                onPressed:(){
                                  Navigator.pop(context);
                                  onOkClicked();
                                } ,
                              )
                            ],
                          );
                        }
                      );
   }

   void showNoConnectionDialogue(BuildContext context){
     showOKDialogue(ERROR, NO_CONNECTION_PLEASE_TRY_AGAIN_LATER,context);
   }

   YYDialog showLoadingDialogue(BuildContext context){
    return YYDialog().build(context)
      ..text(
        text: LOADING,
        fontWeight: FontWeight.bold
      )
      ..divider(
        color: PRIMARY_COLOR
      )
      ..circularProgress(backgroundColor:PRIMARY_COLOR)
      ..text(
        text: CONNECTING_TO_SERVER_PLEASE_WAIT
      )..show();
   }


    /*void showLoadingDialogue(BuildContext context){
     showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){
                          return AlertDialog(
                            title: Text(LOADING),
                            content: SingleChildScrollView(
                              child: Padding(
                                padding:EdgeInsets.all(10.0) ,
                                child:Row(
                                  children: <Widget>[
                                    CircularProgressIndicator(backgroundColor: PRIMARY_COLOR,),
                                    Padding(padding:EdgeInsets.all(10.0) ,),
                                    Text(CONNECTING_TO_SERVER_PLEASE_WAIT)],
                                    )
                                    )
                                    )
                                    );
                      });
   }*/