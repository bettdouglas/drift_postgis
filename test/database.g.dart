// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  const User({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  User copyWith({int? id, String? name}) => User(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User && other.id == this.id && other.name == this.name);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  UsersCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $UserLocationsTable extends UserLocations
    with TableInfo<$UserLocationsTable, UserLocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserLocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<jts.Point> location = GeneratedColumn<jts.Point>(
      'location', aliasedName, false,
      type: PostGISPointType(4326), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, location];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_locations';
  @override
  VerificationContext validateIntegrity(Insertable<UserLocation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserLocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserLocation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      location: attachedDatabase.typeMapping
          .read(PostGISPointType(4326), data['${effectivePrefix}location'])!,
    );
  }

  @override
  $UserLocationsTable createAlias(String alias) {
    return $UserLocationsTable(attachedDatabase, alias);
  }
}

class UserLocation extends DataClass implements Insertable<UserLocation> {
  final int id;
  final int userId;
  final jts.Point location;
  const UserLocation(
      {required this.id, required this.userId, required this.location});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['location'] = Variable<jts.Point>(location, PostGISPointType(4326));
    return map;
  }

  UserLocationsCompanion toCompanion(bool nullToAbsent) {
    return UserLocationsCompanion(
      id: Value(id),
      userId: Value(userId),
      location: Value(location),
    );
  }

  factory UserLocation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserLocation(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      location: serializer.fromJson<jts.Point>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'location': serializer.toJson<jts.Point>(location),
    };
  }

  UserLocation copyWith({int? id, int? userId, jts.Point? location}) =>
      UserLocation(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        location: location ?? this.location,
      );
  @override
  String toString() {
    return (StringBuffer('UserLocation(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserLocation &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.location == this.location);
}

class UserLocationsCompanion extends UpdateCompanion<UserLocation> {
  final Value<int> id;
  final Value<int> userId;
  final Value<jts.Point> location;
  const UserLocationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.location = const Value.absent(),
  });
  UserLocationsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required jts.Point location,
  })  : userId = Value(userId),
        location = Value(location);
  static Insertable<UserLocation> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<jts.Point>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (location != null) 'location': location,
    });
  }

  UserLocationsCompanion copyWith(
      {Value<int>? id, Value<int>? userId, Value<jts.Point>? location}) {
    return UserLocationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (location.present) {
      map['location'] =
          Variable<jts.Point>(location.value, PostGISPointType(4326));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserLocationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $TownsTable extends Towns with TableInfo<$TownsTable, Town> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TownsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _boundaryMeta =
      const VerificationMeta('boundary');
  @override
  late final GeneratedColumn<jts.Polygon> boundary =
      GeneratedColumn<jts.Polygon>('boundary', aliasedName, false,
          type: PostGISPolygonType(4326), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, boundary];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'towns';
  @override
  VerificationContext validateIntegrity(Insertable<Town> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('boundary')) {
      context.handle(_boundaryMeta,
          boundary.isAcceptableOrUnknown(data['boundary']!, _boundaryMeta));
    } else if (isInserting) {
      context.missing(_boundaryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Town map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Town(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      boundary: attachedDatabase.typeMapping
          .read(PostGISPolygonType(4326), data['${effectivePrefix}boundary'])!,
    );
  }

  @override
  $TownsTable createAlias(String alias) {
    return $TownsTable(attachedDatabase, alias);
  }
}

class Town extends DataClass implements Insertable<Town> {
  final int id;
  final String name;
  final jts.Polygon boundary;
  const Town({required this.id, required this.name, required this.boundary});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['boundary'] = Variable<jts.Polygon>(boundary, PostGISPolygonType(4326));
    return map;
  }

  TownsCompanion toCompanion(bool nullToAbsent) {
    return TownsCompanion(
      id: Value(id),
      name: Value(name),
      boundary: Value(boundary),
    );
  }

  factory Town.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Town(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      boundary: serializer.fromJson<jts.Polygon>(json['boundary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'boundary': serializer.toJson<jts.Polygon>(boundary),
    };
  }

  Town copyWith({int? id, String? name, jts.Polygon? boundary}) => Town(
        id: id ?? this.id,
        name: name ?? this.name,
        boundary: boundary ?? this.boundary,
      );
  @override
  String toString() {
    return (StringBuffer('Town(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('boundary: $boundary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, boundary);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Town &&
          other.id == this.id &&
          other.name == this.name &&
          other.boundary == this.boundary);
}

class TownsCompanion extends UpdateCompanion<Town> {
  final Value<int> id;
  final Value<String> name;
  final Value<jts.Polygon> boundary;
  const TownsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.boundary = const Value.absent(),
  });
  TownsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required jts.Polygon boundary,
  })  : name = Value(name),
        boundary = Value(boundary);
  static Insertable<Town> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<jts.Polygon>? boundary,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (boundary != null) 'boundary': boundary,
    });
  }

  TownsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<jts.Polygon>? boundary}) {
    return TownsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      boundary: boundary ?? this.boundary,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (boundary.present) {
      map['boundary'] =
          Variable<jts.Polygon>(boundary.value, PostGISPolygonType(4326));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TownsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('boundary: $boundary')
          ..write(')'))
        .toString();
  }
}

abstract class _$TestDB extends GeneratedDatabase {
  _$TestDB(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $UserLocationsTable userLocations = $UserLocationsTable(this);
  late final $TownsTable towns = $TownsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, userLocations, towns];
}
