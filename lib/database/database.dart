// don't import moor_web.dart or moor_flutter/moor_flutter.dart in shared code
import 'package:moor/moor.dart';
import 'package:undo/undo.dart';
import 'package:videos/data_sources/channel/channel.dart';

export 'database/shared.dart';

part 'database.g.dart';
//flutter packages pub run build_runner build
const String DATABASE_NAME='my_db.db';
const int DATABASE_VERSION=3;
class WatchedVideos extends Table {
  TextColumn get videoId => text()();
  IntColumn get id => integer().autoIncrement()();
  TextColumn get note => text().withDefault(Constant(""))();
  IntColumn get reachedSecond=>integer().withDefault(Constant(0))();
  TextColumn get videoThumbURL=>text()();
  TextColumn get videoTitle => text()();
  ////@override
  ////Set<Column> get primaryKey => {videoId};
}

class FavoriteVideos extends Table {
  TextColumn get videoTitle => text()();
  TextColumn get videoId => text()();
  //TextColumn get videoDescription => text()();
  TextColumn get videoThumbURL=>text()();
}


@UseMoor(tables: [Channels,WatchedVideos,FavoriteVideos])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);
  final cs = ChangeStack();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1)await m.addColumn(watchedVideos,watchedVideos.note);
        if(from<3){
          await m.addColumn(channels,channels.type);
          await m.addColumn(watchedVideos, watchedVideos.videoTitle);
          await m.addColumn(watchedVideos, watchedVideos.videoThumbURL);
          await m.addColumn(watchedVideos, watchedVideos.id);
        }
      },
    );
  }

  Future<List<Channel>> getAllChannels() => select(channels).get();
  Future<List<Channel>> getChannelsById(int id)=>(select(channels)..where((tbl) => tbl.id.equals(id))).get();
  Future insertNewChannel(Channel channelData)=>into(channels).insert(channelData);
  Future updateChannel(Channel channelData)=>update(channels).replace(channelData);


  Future <List<WatchedVideo>>getWatchedVideosById(String id)=>(select(watchedVideos)..where((tbl) => tbl.videoId.equals(id))).get();
  Future addOrUpdateWatchedVideo(WatchedVideosCompanion watchedVideoData)
     => into(watchedVideos).insert(
    WatchedVideosCompanion.insert(videoId: watchedVideoData.videoId.value,
                            note: watchedVideoData.note, 
                            reachedSecond: watchedVideoData.reachedSecond,
                            videoTitle: watchedVideoData.videoTitle.value,
                            videoThumbURL: watchedVideoData.videoThumbURL.value,
                            id: watchedVideoData.id
                            ),
    onConflict: DoUpdate((old) => WatchedVideosCompanion.custom(
      note:Constant<String>(watchedVideoData.note.value),
      reachedSecond: Constant<int>(watchedVideoData.reachedSecond.value)
    )),
  );

  Future<List<FavoriteVideo>> getAllFavoriteVideos()=>select(favoriteVideos).get();
  Future<List<FavoriteVideo>> getFavoriteVideosById(String videoId)=>(select(favoriteVideos)..where((tbl)=>tbl.videoId.equals(videoId))).get();
  Future insertFavoriteVideo(FavoriteVideo favoriteVideo)=>into(favoriteVideos).insert(favoriteVideo);
  Future deleteFavoriteVideo(String videoId)=>(delete(favoriteVideos)..where((tbl)=>tbl.videoId.equals(videoId))).go();
}
