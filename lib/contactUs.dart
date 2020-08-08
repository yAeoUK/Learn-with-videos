import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:videos/c.dart';
import 'package:videos/dialogues.dart';
import 'package:videos/post.dart';

class ContactUsPage extends StatelessWidget{

  final TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(ENTER_QUESTION_OR_SUGGESION_BELOW),
                Padding(
                  padding: EdgeInsets.all(SEPARATOR_PADDING),
                  child: TextFormField(
                    autofocus: true,
                    controller: textEditingController,
                  ),
                ),
                RaisedButton(
                  child: Text(OK),
                  onPressed: () async {
                    showLoadingDialogue(context);
                    Map data=Map();
                    data['suggestion']=textEditingController.text;
                    String result=await Post(context,'suggestion.pnp',data).fetchPost();
                    YYDialog()?.dismiss();
                    if(result=='1'){
                      showOKDialogue(THANKS, DATA_RECEIVED_THANKS, context,onOkClicked:() {
                        Navigator.pop(context);
                      });
                    }
                  },
                )
              ],
            ),
          ),
        )   
      );
  }
}