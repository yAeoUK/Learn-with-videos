// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Channel extends DataClass implements Insertable<Channel> {
  final String name;
  final String link;
  final String pictureLink;
  final int viewed;
  final int getNotifications;
  final String type;
  final int id;
  Channel(
      {@required this.name,
      @required this.link,
      @required this.pictureLink,
      @required this.viewed,
      @required this.getNotifications,
      @required this.type,
      @required this.id});
  factory Channel.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Channel(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      link: stringType.mapFromDatabaseResponse(data['${effectivePrefix}link']),
      pictureLink: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}picture_link']),
      viewed: intType.mapFromDatabaseResponse(data['${effectivePrefix}viewed']),
      getNotifications: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}get_notifications']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || pictureLink != null) {
      map['picture_link'] = Variable<String>(pictureLink);
    }
    if (!nullToAbsent || viewed != null) {
      map['viewed'] = Variable<int>(viewed);
    }
    if (!nullToAbsent || getNotifications != null) {
      map['get_notifications'] = Variable<int>(getNotifications);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    return map;
  }

  ChannelsCompanion toCompanion(bool nullToAbsent) {
    return ChannelsCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      pictureLink: pictureLink == null && nullToAbsent
          ? const Value.absent()
          : Value(pictureLink),
      viewed:
          viewed == null && nullToAbsent ? const Value.absent() : Value(viewed),
      getNotifications: getNotifications == null && nullToAbsent
          ? const Value.absent()
          : Value(getNotifications),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
    );
  }

  factory Channel.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Channel(
      name: serializer.fromJson<String>(json['name']),
      link: serializer.fromJson<String>(json['link']),
      pictureLink: serializer.fromJson<String>(json['pictureLink']),
      viewed: serializer.fromJson<int>(json['viewed']),
      getNotifications: serializer.fromJson<int>(json['getNotifications']),
      type: serializer.fromJson<String>(json['type']),
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'link': serializer.toJson<String>(link),
      'pictureLink': serializer.toJson<String>(pictureLink),
      'viewed': serializer.toJson<int>(viewed),
      'getNotifications': serializer.toJson<int>(getNotifications),
      'type': serializer.toJson<String>(type),
      'id': serializer.toJson<int>(id),
    };
  }

  Channel copyWith(
          {String name,
          String link,
          String pictureLink,
          int viewed,
          int getNotifications,
          String type,
          int id}) =>
      Channel(
        name: name ?? this.name,
        link: link ?? this.link,
        pictureLink: pictureLink ?? this.pictureLink,
        viewed: viewed ?? this.viewed,
        getNotifications: getNotifications ?? this.getNotifications,
        type: type ?? this.type,
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('Channel(')
          ..write('name: $name, ')
          ..write('link: $link, ')
          ..write('pictureLink: $pictureLink, ')
          ..write('viewed: $viewed, ')
          ..write('getNotifications: $getNotifications, ')
          ..write('type: $type, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(
          link.hashCode,
          $mrjc(
              pictureLink.hashCode,
              $mrjc(
                  viewed.hashCode,
                  $mrjc(getNotifications.hashCode,
                      $mrjc(type.hashCode, id.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Channel &&
          other.name == this.name &&
          other.link == this.link &&
          other.pictureLink == this.pictureLink &&
          other.viewed == this.viewed &&
          other.getNotifications == this.getNotifications &&
          other.type == this.type &&
          other.id == this.id);
}

class ChannelsCompanion extends UpdateCompanion<Channel> {
  final Value<String> name;
  final Value<String> link;
  final Value<String> pictureLink;
  final Value<int> viewed;
  final Value<int> getNotifications;
  final Value<String> type;
  final Value<int> id;
  const ChannelsCompanion({
    this.name = const Value.absent(),
    this.link = const Value.absent(),
    this.pictureLink = const Value.absent(),
    this.viewed = const Value.absent(),
    this.getNotifications = const Value.absent(),
    this.type = const Value.absent(),
    this.id = const Value.absent(),
  });
  ChannelsCompanion.insert({
    @required String name,
    @required String link,
    @required String pictureLink,
    this.viewed = const Value.absent(),
    this.getNotifications = const Value.absent(),
    this.type = const Value.absent(),
    this.id = const Value.absent(),
  })  : name = Value(name),
        link = Value(link),
        pictureLink = Value(pictureLink);
  static Insertable<Channel> custom({
    Expression<String> name,
    Expression<String> link,
    Expression<String> pictureLink,
    Expression<int> viewed,
    Expression<int> getNotifications,
    Expression<String> type,
    Expression<int> id,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (link != null) 'link': link,
      if (pictureLink != null) 'picture_link': pictureLink,
      if (viewed != null) 'viewed': viewed,
      if (getNotifications != null) 'get_notifications': getNotifications,
      if (type != null) 'type': type,
      if (id != null) 'id': id,
    });
  }

  ChannelsCompanion copyWith(
      {Value<String> name,
      Value<String> link,
      Value<String> pictureLink,
      Value<int> viewed,
      Value<int> getNotifications,
      Value<String> type,
      Value<int> id}) {
    return ChannelsCompanion(
      name: name ?? this.name,
      link: link ?? this.link,
      pictureLink: pictureLink ?? this.pictureLink,
      viewed: viewed ?? this.viewed,
      getNotifications: getNotifications ?? this.getNotifications,
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (pictureLink.present) {
      map['picture_link'] = Variable<String>(pictureLink.value);
    }
    if (viewed.present) {
      map['viewed'] = Variable<int>(viewed.value);
    }
    if (getNotifications.present) {
      map['get_notifications'] = Variable<int>(getNotifications.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChannelsCompanion(')
          ..write('name: $name, ')
          ..write('link: $link, ')
          ..write('pictureLink: $pictureLink, ')
          ..write('viewed: $viewed, ')
          ..write('getNotifications: $getNotifications, ')
          ..write('type: $type, ')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $ChannelsTable extends Channels with TableInfo<$ChannelsTable, Channel> {
  final GeneratedDatabase _db;
  final String _alias;
  $ChannelsTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _linkMeta = const VerificationMeta('link');
  GeneratedTextColumn _link;
  @override
  GeneratedTextColumn get link => _link ??= _constructLink();
  GeneratedTextColumn _constructLink() {
    return GeneratedTextColumn(
      'link',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pictureLinkMeta =
      const VerificationMeta('pictureLink');
  GeneratedTextColumn _pictureLink;
  @override
  GeneratedTextColumn get pictureLink =>
      _pictureLink ??= _constructPictureLink();
  GeneratedTextColumn _constructPictureLink() {
    return GeneratedTextColumn(
      'picture_link',
      $tableName,
      false,
    );
  }

  final VerificationMeta _viewedMeta = const VerificationMeta('viewed');
  GeneratedIntColumn _viewed;
  @override
  GeneratedIntColumn get viewed => _viewed ??= _constructViewed();
  GeneratedIntColumn _constructViewed() {
    return GeneratedIntColumn('viewed', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _getNotificationsMeta =
      const VerificationMeta('getNotifications');
  GeneratedIntColumn _getNotifications;
  @override
  GeneratedIntColumn get getNotifications =>
      _getNotifications ??= _constructGetNotifications();
  GeneratedIntColumn _constructGetNotifications() {
    return GeneratedIntColumn('get_notifications', $tableName, false,
        defaultValue: Constant(1));
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn('type', $tableName, false,
        defaultValue: Constant('youtube'));
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  @override
  List<GeneratedColumn> get $columns =>
      [name, link, pictureLink, viewed, getNotifications, type, id];
  @override
  $ChannelsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'channels';
  @override
  final String actualTableName = 'channels';
  @override
  VerificationContext validateIntegrity(Insertable<Channel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link'], _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('picture_link')) {
      context.handle(
          _pictureLinkMeta,
          pictureLink.isAcceptableOrUnknown(
              data['picture_link'], _pictureLinkMeta));
    } else if (isInserting) {
      context.missing(_pictureLinkMeta);
    }
    if (data.containsKey('viewed')) {
      context.handle(_viewedMeta,
          viewed.isAcceptableOrUnknown(data['viewed'], _viewedMeta));
    }
    if (data.containsKey('get_notifications')) {
      context.handle(
          _getNotificationsMeta,
          getNotifications.isAcceptableOrUnknown(
              data['get_notifications'], _getNotificationsMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Channel map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Channel.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ChannelsTable createAlias(String alias) {
    return $ChannelsTable(_db, alias);
  }
}

class WatchedVideo extends DataClass implements Insertable<WatchedVideo> {
  final String videoId;
  final int id;
  final String note;
  final int reachedSecond;
  final String videoThumbURL;
  final String videoTitle;
  WatchedVideo(
      {@required this.videoId,
      @required this.id,
      @required this.note,
      @required this.reachedSecond,
      @required this.videoThumbURL,
      @required this.videoTitle});
  factory WatchedVideo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return WatchedVideo(
      videoId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}video_id']),
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
      reachedSecond: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}reached_second']),
      videoThumbURL: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}video_thumb_u_r_l']),
      videoTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}video_title']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || videoId != null) {
      map['video_id'] = Variable<String>(videoId);
    }
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || reachedSecond != null) {
      map['reached_second'] = Variable<int>(reachedSecond);
    }
    if (!nullToAbsent || videoThumbURL != null) {
      map['video_thumb_u_r_l'] = Variable<String>(videoThumbURL);
    }
    if (!nullToAbsent || videoTitle != null) {
      map['video_title'] = Variable<String>(videoTitle);
    }
    return map;
  }

  WatchedVideosCompanion toCompanion(bool nullToAbsent) {
    return WatchedVideosCompanion(
      videoId: videoId == null && nullToAbsent
          ? const Value.absent()
          : Value(videoId),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      reachedSecond: reachedSecond == null && nullToAbsent
          ? const Value.absent()
          : Value(reachedSecond),
      videoThumbURL: videoThumbURL == null && nullToAbsent
          ? const Value.absent()
          : Value(videoThumbURL),
      videoTitle: videoTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(videoTitle),
    );
  }

  factory WatchedVideo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return WatchedVideo(
      videoId: serializer.fromJson<String>(json['videoId']),
      id: serializer.fromJson<int>(json['id']),
      note: serializer.fromJson<String>(json['note']),
      reachedSecond: serializer.fromJson<int>(json['reachedSecond']),
      videoThumbURL: serializer.fromJson<String>(json['videoThumbURL']),
      videoTitle: serializer.fromJson<String>(json['videoTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'videoId': serializer.toJson<String>(videoId),
      'id': serializer.toJson<int>(id),
      'note': serializer.toJson<String>(note),
      'reachedSecond': serializer.toJson<int>(reachedSecond),
      'videoThumbURL': serializer.toJson<String>(videoThumbURL),
      'videoTitle': serializer.toJson<String>(videoTitle),
    };
  }

  WatchedVideo copyWith(
          {String videoId,
          int id,
          String note,
          int reachedSecond,
          String videoThumbURL,
          String videoTitle}) =>
      WatchedVideo(
        videoId: videoId ?? this.videoId,
        id: id ?? this.id,
        note: note ?? this.note,
        reachedSecond: reachedSecond ?? this.reachedSecond,
        videoThumbURL: videoThumbURL ?? this.videoThumbURL,
        videoTitle: videoTitle ?? this.videoTitle,
      );
  @override
  String toString() {
    return (StringBuffer('WatchedVideo(')
          ..write('videoId: $videoId, ')
          ..write('id: $id, ')
          ..write('note: $note, ')
          ..write('reachedSecond: $reachedSecond, ')
          ..write('videoThumbURL: $videoThumbURL, ')
          ..write('videoTitle: $videoTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      videoId.hashCode,
      $mrjc(
          id.hashCode,
          $mrjc(
              note.hashCode,
              $mrjc(reachedSecond.hashCode,
                  $mrjc(videoThumbURL.hashCode, videoTitle.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is WatchedVideo &&
          other.videoId == this.videoId &&
          other.id == this.id &&
          other.note == this.note &&
          other.reachedSecond == this.reachedSecond &&
          other.videoThumbURL == this.videoThumbURL &&
          other.videoTitle == this.videoTitle);
}

class WatchedVideosCompanion extends UpdateCompanion<WatchedVideo> {
  final Value<String> videoId;
  final Value<int> id;
  final Value<String> note;
  final Value<int> reachedSecond;
  final Value<String> videoThumbURL;
  final Value<String> videoTitle;
  const WatchedVideosCompanion({
    this.videoId = const Value.absent(),
    this.id = const Value.absent(),
    this.note = const Value.absent(),
    this.reachedSecond = const Value.absent(),
    this.videoThumbURL = const Value.absent(),
    this.videoTitle = const Value.absent(),
  });
  WatchedVideosCompanion.insert({
    @required String videoId,
    this.id = const Value.absent(),
    this.note = const Value.absent(),
    this.reachedSecond = const Value.absent(),
    @required String videoThumbURL,
    @required String videoTitle,
  })  : videoId = Value(videoId),
        videoThumbURL = Value(videoThumbURL),
        videoTitle = Value(videoTitle);
  static Insertable<WatchedVideo> custom({
    Expression<String> videoId,
    Expression<int> id,
    Expression<String> note,
    Expression<int> reachedSecond,
    Expression<String> videoThumbURL,
    Expression<String> videoTitle,
  }) {
    return RawValuesInsertable({
      if (videoId != null) 'video_id': videoId,
      if (id != null) 'id': id,
      if (note != null) 'note': note,
      if (reachedSecond != null) 'reached_second': reachedSecond,
      if (videoThumbURL != null) 'video_thumb_u_r_l': videoThumbURL,
      if (videoTitle != null) 'video_title': videoTitle,
    });
  }

  WatchedVideosCompanion copyWith(
      {Value<String> videoId,
      Value<int> id,
      Value<String> note,
      Value<int> reachedSecond,
      Value<String> videoThumbURL,
      Value<String> videoTitle}) {
    return WatchedVideosCompanion(
      videoId: videoId ?? this.videoId,
      id: id ?? this.id,
      note: note ?? this.note,
      reachedSecond: reachedSecond ?? this.reachedSecond,
      videoThumbURL: videoThumbURL ?? this.videoThumbURL,
      videoTitle: videoTitle ?? this.videoTitle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (reachedSecond.present) {
      map['reached_second'] = Variable<int>(reachedSecond.value);
    }
    if (videoThumbURL.present) {
      map['video_thumb_u_r_l'] = Variable<String>(videoThumbURL.value);
    }
    if (videoTitle.present) {
      map['video_title'] = Variable<String>(videoTitle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchedVideosCompanion(')
          ..write('videoId: $videoId, ')
          ..write('id: $id, ')
          ..write('note: $note, ')
          ..write('reachedSecond: $reachedSecond, ')
          ..write('videoThumbURL: $videoThumbURL, ')
          ..write('videoTitle: $videoTitle')
          ..write(')'))
        .toString();
  }
}

class $WatchedVideosTable extends WatchedVideos
    with TableInfo<$WatchedVideosTable, WatchedVideo> {
  final GeneratedDatabase _db;
  final String _alias;
  $WatchedVideosTable(this._db, [this._alias]);
  final VerificationMeta _videoIdMeta = const VerificationMeta('videoId');
  GeneratedTextColumn _videoId;
  @override
  GeneratedTextColumn get videoId => _videoId ??= _constructVideoId();
  GeneratedTextColumn _constructVideoId() {
    return GeneratedTextColumn(
      'video_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn('note', $tableName, false,
        defaultValue: Constant(""));
  }

  final VerificationMeta _reachedSecondMeta =
      const VerificationMeta('reachedSecond');
  GeneratedIntColumn _reachedSecond;
  @override
  GeneratedIntColumn get reachedSecond =>
      _reachedSecond ??= _constructReachedSecond();
  GeneratedIntColumn _constructReachedSecond() {
    return GeneratedIntColumn('reached_second', $tableName, false,
        defaultValue: Constant(0));
  }

  final VerificationMeta _videoThumbURLMeta =
      const VerificationMeta('videoThumbURL');
  GeneratedTextColumn _videoThumbURL;
  @override
  GeneratedTextColumn get videoThumbURL =>
      _videoThumbURL ??= _constructVideoThumbURL();
  GeneratedTextColumn _constructVideoThumbURL() {
    return GeneratedTextColumn(
      'video_thumb_u_r_l',
      $tableName,
      false,
    );
  }

  final VerificationMeta _videoTitleMeta = const VerificationMeta('videoTitle');
  GeneratedTextColumn _videoTitle;
  @override
  GeneratedTextColumn get videoTitle => _videoTitle ??= _constructVideoTitle();
  GeneratedTextColumn _constructVideoTitle() {
    return GeneratedTextColumn(
      'video_title',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [videoId, id, note, reachedSecond, videoThumbURL, videoTitle];
  @override
  $WatchedVideosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'watched_videos';
  @override
  final String actualTableName = 'watched_videos';
  @override
  VerificationContext validateIntegrity(Insertable<WatchedVideo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id'], _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note'], _noteMeta));
    }
    if (data.containsKey('reached_second')) {
      context.handle(
          _reachedSecondMeta,
          reachedSecond.isAcceptableOrUnknown(
              data['reached_second'], _reachedSecondMeta));
    }
    if (data.containsKey('video_thumb_u_r_l')) {
      context.handle(
          _videoThumbURLMeta,
          videoThumbURL.isAcceptableOrUnknown(
              data['video_thumb_u_r_l'], _videoThumbURLMeta));
    } else if (isInserting) {
      context.missing(_videoThumbURLMeta);
    }
    if (data.containsKey('video_title')) {
      context.handle(
          _videoTitleMeta,
          videoTitle.isAcceptableOrUnknown(
              data['video_title'], _videoTitleMeta));
    } else if (isInserting) {
      context.missing(_videoTitleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WatchedVideo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return WatchedVideo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $WatchedVideosTable createAlias(String alias) {
    return $WatchedVideosTable(_db, alias);
  }
}

class FavoriteVideo extends DataClass implements Insertable<FavoriteVideo> {
  final String videoTitle;
  final String videoId;
  final String videoThumbURL;
  FavoriteVideo(
      {@required this.videoTitle,
      @required this.videoId,
      @required this.videoThumbURL});
  factory FavoriteVideo.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return FavoriteVideo(
      videoTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}video_title']),
      videoId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}video_id']),
      videoThumbURL: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}video_thumb_u_r_l']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || videoTitle != null) {
      map['video_title'] = Variable<String>(videoTitle);
    }
    if (!nullToAbsent || videoId != null) {
      map['video_id'] = Variable<String>(videoId);
    }
    if (!nullToAbsent || videoThumbURL != null) {
      map['video_thumb_u_r_l'] = Variable<String>(videoThumbURL);
    }
    return map;
  }

  FavoriteVideosCompanion toCompanion(bool nullToAbsent) {
    return FavoriteVideosCompanion(
      videoTitle: videoTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(videoTitle),
      videoId: videoId == null && nullToAbsent
          ? const Value.absent()
          : Value(videoId),
      videoThumbURL: videoThumbURL == null && nullToAbsent
          ? const Value.absent()
          : Value(videoThumbURL),
    );
  }

  factory FavoriteVideo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return FavoriteVideo(
      videoTitle: serializer.fromJson<String>(json['videoTitle']),
      videoId: serializer.fromJson<String>(json['videoId']),
      videoThumbURL: serializer.fromJson<String>(json['videoThumbURL']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'videoTitle': serializer.toJson<String>(videoTitle),
      'videoId': serializer.toJson<String>(videoId),
      'videoThumbURL': serializer.toJson<String>(videoThumbURL),
    };
  }

  FavoriteVideo copyWith(
          {String videoTitle, String videoId, String videoThumbURL}) =>
      FavoriteVideo(
        videoTitle: videoTitle ?? this.videoTitle,
        videoId: videoId ?? this.videoId,
        videoThumbURL: videoThumbURL ?? this.videoThumbURL,
      );
  @override
  String toString() {
    return (StringBuffer('FavoriteVideo(')
          ..write('videoTitle: $videoTitle, ')
          ..write('videoId: $videoId, ')
          ..write('videoThumbURL: $videoThumbURL')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      videoTitle.hashCode, $mrjc(videoId.hashCode, videoThumbURL.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is FavoriteVideo &&
          other.videoTitle == this.videoTitle &&
          other.videoId == this.videoId &&
          other.videoThumbURL == this.videoThumbURL);
}

class FavoriteVideosCompanion extends UpdateCompanion<FavoriteVideo> {
  final Value<String> videoTitle;
  final Value<String> videoId;
  final Value<String> videoThumbURL;
  const FavoriteVideosCompanion({
    this.videoTitle = const Value.absent(),
    this.videoId = const Value.absent(),
    this.videoThumbURL = const Value.absent(),
  });
  FavoriteVideosCompanion.insert({
    @required String videoTitle,
    @required String videoId,
    @required String videoThumbURL,
  })  : videoTitle = Value(videoTitle),
        videoId = Value(videoId),
        videoThumbURL = Value(videoThumbURL);
  static Insertable<FavoriteVideo> custom({
    Expression<String> videoTitle,
    Expression<String> videoId,
    Expression<String> videoThumbURL,
  }) {
    return RawValuesInsertable({
      if (videoTitle != null) 'video_title': videoTitle,
      if (videoId != null) 'video_id': videoId,
      if (videoThumbURL != null) 'video_thumb_u_r_l': videoThumbURL,
    });
  }

  FavoriteVideosCompanion copyWith(
      {Value<String> videoTitle,
      Value<String> videoId,
      Value<String> videoThumbURL}) {
    return FavoriteVideosCompanion(
      videoTitle: videoTitle ?? this.videoTitle,
      videoId: videoId ?? this.videoId,
      videoThumbURL: videoThumbURL ?? this.videoThumbURL,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (videoTitle.present) {
      map['video_title'] = Variable<String>(videoTitle.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (videoThumbURL.present) {
      map['video_thumb_u_r_l'] = Variable<String>(videoThumbURL.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteVideosCompanion(')
          ..write('videoTitle: $videoTitle, ')
          ..write('videoId: $videoId, ')
          ..write('videoThumbURL: $videoThumbURL')
          ..write(')'))
        .toString();
  }
}

class $FavoriteVideosTable extends FavoriteVideos
    with TableInfo<$FavoriteVideosTable, FavoriteVideo> {
  final GeneratedDatabase _db;
  final String _alias;
  $FavoriteVideosTable(this._db, [this._alias]);
  final VerificationMeta _videoTitleMeta = const VerificationMeta('videoTitle');
  GeneratedTextColumn _videoTitle;
  @override
  GeneratedTextColumn get videoTitle => _videoTitle ??= _constructVideoTitle();
  GeneratedTextColumn _constructVideoTitle() {
    return GeneratedTextColumn(
      'video_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _videoIdMeta = const VerificationMeta('videoId');
  GeneratedTextColumn _videoId;
  @override
  GeneratedTextColumn get videoId => _videoId ??= _constructVideoId();
  GeneratedTextColumn _constructVideoId() {
    return GeneratedTextColumn(
      'video_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _videoThumbURLMeta =
      const VerificationMeta('videoThumbURL');
  GeneratedTextColumn _videoThumbURL;
  @override
  GeneratedTextColumn get videoThumbURL =>
      _videoThumbURL ??= _constructVideoThumbURL();
  GeneratedTextColumn _constructVideoThumbURL() {
    return GeneratedTextColumn(
      'video_thumb_u_r_l',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [videoTitle, videoId, videoThumbURL];
  @override
  $FavoriteVideosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'favorite_videos';
  @override
  final String actualTableName = 'favorite_videos';
  @override
  VerificationContext validateIntegrity(Insertable<FavoriteVideo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('video_title')) {
      context.handle(
          _videoTitleMeta,
          videoTitle.isAcceptableOrUnknown(
              data['video_title'], _videoTitleMeta));
    } else if (isInserting) {
      context.missing(_videoTitleMeta);
    }
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id'], _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('video_thumb_u_r_l')) {
      context.handle(
          _videoThumbURLMeta,
          videoThumbURL.isAcceptableOrUnknown(
              data['video_thumb_u_r_l'], _videoThumbURLMeta));
    } else if (isInserting) {
      context.missing(_videoThumbURLMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  FavoriteVideo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return FavoriteVideo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $FavoriteVideosTable createAlias(String alias) {
    return $FavoriteVideosTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ChannelsTable _channels;
  $ChannelsTable get channels => _channels ??= $ChannelsTable(this);
  $WatchedVideosTable _watchedVideos;
  $WatchedVideosTable get watchedVideos =>
      _watchedVideos ??= $WatchedVideosTable(this);
  $FavoriteVideosTable _favoriteVideos;
  $FavoriteVideosTable get favoriteVideos =>
      _favoriteVideos ??= $FavoriteVideosTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [channels, watchedVideos, favoriteVideos];
}
