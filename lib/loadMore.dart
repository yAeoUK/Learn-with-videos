import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videos/c.dart';

class LoadMore extends StatefulWidget{

  final onClick;
  final loading;
  LoadMore({this.onClick,this.loading});
  @override
  State<StatefulWidget> createState()=>LoadMoreState();
}

class LoadMoreState extends State<LoadMore>{
  bool loading;Future onClick;

  @override
  void initState() {
    super.initState();
    loading=widget.loading;
    onClick=widget.onClick;
    configureLoading();
  }

  void configureLoading()async{
    /*setState(() {
      
    });
    if(loading){
      await onClick;
      setState(() {
        loading=false;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return loading?CircularProgressIndicator(
      backgroundColor: PRIMARY_COLOR,
    ):
    RaisedButton(
      onPressed: () { 
        loading=true;
        configureLoading();
       },
      child: Text(LOADING),
      color: PRIMARY_COLOR,
    );
  }
}