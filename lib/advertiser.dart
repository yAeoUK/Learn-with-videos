import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moor_flutter/moor_flutter.dart' as database;
import 'package:videos/database/database.dart';

import 'VideoList.dart';
import 'c.dart';

class Advertiser extends StatefulWidget{
  final Channel channel;
  Advertiser({this.channel});
  @override
  State<StatefulWidget> createState()=>AdvertiserState();

}

class AdvertiserState extends State<Advertiser>{
  @override
  Widget build(BuildContext context) {
    Channel channel=widget.channel;
    return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoListPage(
                                channel:channel ,
                                )
                              )
                            );
                            Database d=RepositoryProvider.of<Database>(context);
                            (d.update($ChannelsTable(d))
                              ..where((t) => t.id.equals(channel.id)))
                            .write(ChannelsCompanion(
                              viewed: database.Value(1),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(SEPARATOR_PADDING/2.0),
                                    child: ClipOval(
                                      child:Hero(
                                        tag: channel.pictureLink,
                                        child: CachedNetworkImage(
                                          imageUrl:channel.pictureLink,
                                          fit: BoxFit.fill,
                                          placeholder:(context,text)=> Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        ),
                                      )
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: channel.viewed==0?PRIMARY_COLOR:Colors.grey,
                                        width: SEPARATOR_PADDING/2
                                      ),
                                      shape: BoxShape.circle,
                                      ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Hero(
                                      tag: channel.name,
                                      child: Text(channel.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),
                                           ),
                                    )
                                  )
                                )
                              ],
                            )
                        ),
                      );
                      
  }

}

