import 'package:moor/moor.dart';
import 'package:flutter/foundation.dart';
import 'package:moor/moor_web.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'data_sources/channel/channel.dart';
part 'database.g.dart';
//flutter packages pub run build_runner build

const String DATABASE_NAME='my_db.db';
const int DATABASE_VERSION=3;

/*const WATCHEDVIDEOS='watchedVideos';
const VIDEOID='videoId';
const REACHEDSECOND='reachedSecond';
const NOTE='note';*/

//const TABLEFAVORITEVIDEOS='favoriteVideos';
//const VIDEOTITLE='videoTitle';
///VIDEO_ID
//const VIDEODESCRIPTION='videoDescription';
//const VIDEOTHUMBURL='videoThumbURL';

//const CHANNELS='channels';
//const ID='id';
//const NAME='name';
//const LINK='link';
//const PICTURE_LINK='pictureLink';
//const VIEWED='viewed';
//const GETNOTIFICATIONS='getNotifications';

class WatchedVideos extends Table {
  TextColumn get videoId => text()();
  //IntColumn get id => integer().autoIncrement()();
  TextColumn get note => text().withDefault(Constant(""))();
  IntColumn get reachedSecond=>integer().withDefault(Constant(0))();

  @override
  Set<Column> get primaryKey => {videoId};
}

class FavoriteVideos extends Table {
  TextColumn get videoTitle => text()();
  TextColumn get videoId => text()();
  //TextColumn get videoDescription => text()();
  TextColumn get videoThumbURL=>text()();
}

@UseMoor(tables: [Channels,WatchedVideos,FavoriteVideos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() 
      : super(//kIsWeb?WebDatabase(DATABASE_NAME):
         FlutterQueryExecutor.inDatabaseFolder(
            path: DATABASE_NAME, logStatements: true));
  int get schemaVersion => DATABASE_VERSION;
  Future<List<Channel>> getAllChannels() => select(channels).get();
  Future<List<Channel>> getChannelsById(int id)=>(select(channels)..where((tbl) => tbl.id.equals(id))).get();
  Future insertNewChannel(Channel channelData)=>into(channels).insert(channelData);
  Future updateChannel(Channel channelData)=>update(channels).replace(channelData);


  Future <List<WatchedVideo>>getWatchedVideosById(String id)=>(select(watchedVideos)..where((tbl) => tbl.videoId.equals(id))).get();
  Future addOrUpdateWatchedVideo(WatchedVideo watchedVideoData)
     => into(watchedVideos).insert(
    WatchedVideosCompanion.insert(videoId: watchedVideoData.videoId,
                            note: Value<String>(watchedVideoData.note), 
                            reachedSecond: Value<int>(watchedVideoData.reachedSecond)),
    onConflict: DoUpdate((old) => WatchedVideosCompanion.custom(
      note:Constant<String>(watchedVideoData.note),
      reachedSecond: Constant<int>(watchedVideoData.reachedSecond)
    )),
  );

  Future<List<FavoriteVideo>> getAllFavoriteVideos()=>select(favoriteVideos).get();
  Future<List<FavoriteVideo>> getFavoriteVideosById(String videoId)=>(select(favoriteVideos)..where((tbl)=>tbl.videoId.equals(videoId))).get();
  Future insertFavoriteVideo(FavoriteVideo favoriteVideo)=>into(favoriteVideos).insert(favoriteVideo);
  Future deleteFavoriteVideo(String videoId)=>(delete(favoriteVideos)..where((tbl)=>tbl.videoId.equals(videoId))).go();
}