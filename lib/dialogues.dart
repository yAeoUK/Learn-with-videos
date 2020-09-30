import 'package:flutter/material.dart';
import 'c.dart';

void showOKDialogue(String title,String content,BuildContext context,{VoidCallback onOkClicked}){
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
                                  if(onOkClicked!=null)onOkClicked();
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

   /*YYDialog showLoadingDialogue(BuildContext context){
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
   }*/


    void showLoadingDialogue(BuildContext context){
     showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){
                          return AlertDialog(
                            title: Text(LOADING),
                            content: SingleChildScrollView(
                                child:ListBody(
                                  children: <Widget>[
                                    Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: PRIMARY_COLOR,
                                        ),
                                    ),
                                    Text(CONNECTING_TO_SERVER_PLEASE_WAIT)],
                                    )
                                    )
                                    );
                      });
   }