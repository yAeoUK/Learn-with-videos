import 'package:moor/moor.dart';

class Channels extends Table{
  TextColumn get name=>text()();
  TextColumn get link =>text()();
  TextColumn get pictureLink=>text()();
  IntColumn get viewed=>integer().withDefault(Constant(0))();
  IntColumn get getNotifications=>integer().withDefault(Constant(1))();
  TextColumn get type=>text().withDefault(Constant('youtube'))();
  IntColumn get id=>integer().autoIncrement()();
  }