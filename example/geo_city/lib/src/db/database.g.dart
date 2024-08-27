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
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

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
  UserLocation copyWithCompanion(UserLocationsCompanion data) {
    return UserLocation(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      location: data.location.present ? data.location.value : this.location,
    );
  }

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
  Town copyWithCompanion(TownsCompanion data) {
    return Town(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      boundary: data.boundary.present ? data.boundary.value : this.boundary,
    );
  }

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

class $ParksTable extends Parks with TableInfo<$ParksTable, Park> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _areasMeta = const VerificationMeta('areas');
  @override
  late final GeneratedColumn<jts.MultiPolygon> areas =
      GeneratedColumn<jts.MultiPolygon>('areas', aliasedName, false,
          type: PostGISMultiPolygonType(4326), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, areas];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parks';
  @override
  VerificationContext validateIntegrity(Insertable<Park> instance,
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
    if (data.containsKey('areas')) {
      context.handle(
          _areasMeta, areas.isAcceptableOrUnknown(data['areas']!, _areasMeta));
    } else if (isInserting) {
      context.missing(_areasMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Park map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Park(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      areas: attachedDatabase.typeMapping.read(
          PostGISMultiPolygonType(4326), data['${effectivePrefix}areas'])!,
    );
  }

  @override
  $ParksTable createAlias(String alias) {
    return $ParksTable(attachedDatabase, alias);
  }
}

class Park extends DataClass implements Insertable<Park> {
  final int id;
  final String name;
  final jts.MultiPolygon areas;
  const Park({required this.id, required this.name, required this.areas});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['areas'] =
        Variable<jts.MultiPolygon>(areas, PostGISMultiPolygonType(4326));
    return map;
  }

  ParksCompanion toCompanion(bool nullToAbsent) {
    return ParksCompanion(
      id: Value(id),
      name: Value(name),
      areas: Value(areas),
    );
  }

  factory Park.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Park(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      areas: serializer.fromJson<jts.MultiPolygon>(json['areas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'areas': serializer.toJson<jts.MultiPolygon>(areas),
    };
  }

  Park copyWith({int? id, String? name, jts.MultiPolygon? areas}) => Park(
        id: id ?? this.id,
        name: name ?? this.name,
        areas: areas ?? this.areas,
      );
  Park copyWithCompanion(ParksCompanion data) {
    return Park(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      areas: data.areas.present ? data.areas.value : this.areas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Park(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('areas: $areas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, areas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Park &&
          other.id == this.id &&
          other.name == this.name &&
          other.areas == this.areas);
}

class ParksCompanion extends UpdateCompanion<Park> {
  final Value<int> id;
  final Value<String> name;
  final Value<jts.MultiPolygon> areas;
  const ParksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.areas = const Value.absent(),
  });
  ParksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required jts.MultiPolygon areas,
  })  : name = Value(name),
        areas = Value(areas);
  static Insertable<Park> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<jts.MultiPolygon>? areas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (areas != null) 'areas': areas,
    });
  }

  ParksCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<jts.MultiPolygon>? areas}) {
    return ParksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      areas: areas ?? this.areas,
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
    if (areas.present) {
      map['areas'] = Variable<jts.MultiPolygon>(
          areas.value, PostGISMultiPolygonType(4326));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('areas: $areas')
          ..write(')'))
        .toString();
  }
}

class $BusRoutesTable extends BusRoutes
    with TableInfo<$BusRoutesTable, BusRoute> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusRoutesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _routeNameMeta =
      const VerificationMeta('routeName');
  @override
  late final GeneratedColumn<String> routeName = GeneratedColumn<String>(
      'route_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<jts.MultiLineString> path =
      GeneratedColumn<jts.MultiLineString>('path', aliasedName, false,
          type: PostGISMultiLineStringType(4326), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, routeName, path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bus_routes';
  @override
  VerificationContext validateIntegrity(Insertable<BusRoute> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('route_name')) {
      context.handle(_routeNameMeta,
          routeName.isAcceptableOrUnknown(data['route_name']!, _routeNameMeta));
    } else if (isInserting) {
      context.missing(_routeNameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusRoute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusRoute(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      routeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}route_name'])!,
      path: attachedDatabase.typeMapping.read(
          PostGISMultiLineStringType(4326), data['${effectivePrefix}path'])!,
    );
  }

  @override
  $BusRoutesTable createAlias(String alias) {
    return $BusRoutesTable(attachedDatabase, alias);
  }
}

class BusRoute extends DataClass implements Insertable<BusRoute> {
  final int id;
  final String routeName;
  final jts.MultiLineString path;
  const BusRoute(
      {required this.id, required this.routeName, required this.path});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['route_name'] = Variable<String>(routeName);
    map['path'] =
        Variable<jts.MultiLineString>(path, PostGISMultiLineStringType(4326));
    return map;
  }

  BusRoutesCompanion toCompanion(bool nullToAbsent) {
    return BusRoutesCompanion(
      id: Value(id),
      routeName: Value(routeName),
      path: Value(path),
    );
  }

  factory BusRoute.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusRoute(
      id: serializer.fromJson<int>(json['id']),
      routeName: serializer.fromJson<String>(json['routeName']),
      path: serializer.fromJson<jts.MultiLineString>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routeName': serializer.toJson<String>(routeName),
      'path': serializer.toJson<jts.MultiLineString>(path),
    };
  }

  BusRoute copyWith({int? id, String? routeName, jts.MultiLineString? path}) =>
      BusRoute(
        id: id ?? this.id,
        routeName: routeName ?? this.routeName,
        path: path ?? this.path,
      );
  BusRoute copyWithCompanion(BusRoutesCompanion data) {
    return BusRoute(
      id: data.id.present ? data.id.value : this.id,
      routeName: data.routeName.present ? data.routeName.value : this.routeName,
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusRoute(')
          ..write('id: $id, ')
          ..write('routeName: $routeName, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routeName, path);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusRoute &&
          other.id == this.id &&
          other.routeName == this.routeName &&
          other.path == this.path);
}

class BusRoutesCompanion extends UpdateCompanion<BusRoute> {
  final Value<int> id;
  final Value<String> routeName;
  final Value<jts.MultiLineString> path;
  const BusRoutesCompanion({
    this.id = const Value.absent(),
    this.routeName = const Value.absent(),
    this.path = const Value.absent(),
  });
  BusRoutesCompanion.insert({
    this.id = const Value.absent(),
    required String routeName,
    required jts.MultiLineString path,
  })  : routeName = Value(routeName),
        path = Value(path);
  static Insertable<BusRoute> custom({
    Expression<int>? id,
    Expression<String>? routeName,
    Expression<jts.MultiLineString>? path,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routeName != null) 'route_name': routeName,
      if (path != null) 'path': path,
    });
  }

  BusRoutesCompanion copyWith(
      {Value<int>? id,
      Value<String>? routeName,
      Value<jts.MultiLineString>? path}) {
    return BusRoutesCompanion(
      id: id ?? this.id,
      routeName: routeName ?? this.routeName,
      path: path ?? this.path,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routeName.present) {
      map['route_name'] = Variable<String>(routeName.value);
    }
    if (path.present) {
      map['path'] = Variable<jts.MultiLineString>(
          path.value, PostGISMultiLineStringType(4326));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusRoutesCompanion(')
          ..write('id: $id, ')
          ..write('routeName: $routeName, ')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }
}

class $TouristAttractionsTable extends TouristAttractions
    with TableInfo<$TouristAttractionsTable, TouristAttraction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TouristAttractionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _locationsMeta =
      const VerificationMeta('locations');
  @override
  late final GeneratedColumn<jts.MultiPoint> locations =
      GeneratedColumn<jts.MultiPoint>('locations', aliasedName, false,
          type: PostGISMultiPointType(4326), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, locations];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tourist_attractions';
  @override
  VerificationContext validateIntegrity(Insertable<TouristAttraction> instance,
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
    if (data.containsKey('locations')) {
      context.handle(_locationsMeta,
          locations.isAcceptableOrUnknown(data['locations']!, _locationsMeta));
    } else if (isInserting) {
      context.missing(_locationsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TouristAttraction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TouristAttraction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      locations: attachedDatabase.typeMapping.read(
          PostGISMultiPointType(4326), data['${effectivePrefix}locations'])!,
    );
  }

  @override
  $TouristAttractionsTable createAlias(String alias) {
    return $TouristAttractionsTable(attachedDatabase, alias);
  }
}

class TouristAttraction extends DataClass
    implements Insertable<TouristAttraction> {
  final int id;
  final String name;
  final jts.MultiPoint locations;
  const TouristAttraction(
      {required this.id, required this.name, required this.locations});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['locations'] =
        Variable<jts.MultiPoint>(locations, PostGISMultiPointType(4326));
    return map;
  }

  TouristAttractionsCompanion toCompanion(bool nullToAbsent) {
    return TouristAttractionsCompanion(
      id: Value(id),
      name: Value(name),
      locations: Value(locations),
    );
  }

  factory TouristAttraction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TouristAttraction(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      locations: serializer.fromJson<jts.MultiPoint>(json['locations']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'locations': serializer.toJson<jts.MultiPoint>(locations),
    };
  }

  TouristAttraction copyWith(
          {int? id, String? name, jts.MultiPoint? locations}) =>
      TouristAttraction(
        id: id ?? this.id,
        name: name ?? this.name,
        locations: locations ?? this.locations,
      );
  TouristAttraction copyWithCompanion(TouristAttractionsCompanion data) {
    return TouristAttraction(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      locations: data.locations.present ? data.locations.value : this.locations,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TouristAttraction(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('locations: $locations')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, locations);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TouristAttraction &&
          other.id == this.id &&
          other.name == this.name &&
          other.locations == this.locations);
}

class TouristAttractionsCompanion extends UpdateCompanion<TouristAttraction> {
  final Value<int> id;
  final Value<String> name;
  final Value<jts.MultiPoint> locations;
  const TouristAttractionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.locations = const Value.absent(),
  });
  TouristAttractionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required jts.MultiPoint locations,
  })  : name = Value(name),
        locations = Value(locations);
  static Insertable<TouristAttraction> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<jts.MultiPoint>? locations,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (locations != null) 'locations': locations,
    });
  }

  TouristAttractionsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<jts.MultiPoint>? locations}) {
    return TouristAttractionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      locations: locations ?? this.locations,
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
    if (locations.present) {
      map['locations'] = Variable<jts.MultiPoint>(
          locations.value, PostGISMultiPointType(4326));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TouristAttractionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('locations: $locations')
          ..write(')'))
        .toString();
  }
}

abstract class _$GeoCityDatabase extends GeneratedDatabase {
  _$GeoCityDatabase(QueryExecutor e) : super(e);
  $GeoCityDatabaseManager get managers => $GeoCityDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UserLocationsTable userLocations = $UserLocationsTable(this);
  late final $TownsTable towns = $TownsTable(this);
  late final $ParksTable parks = $ParksTable(this);
  late final $BusRoutesTable busRoutes = $BusRoutesTable(this);
  late final $TouristAttractionsTable touristAttractions =
      $TouristAttractionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, userLocations, towns, parks, busRoutes, touristAttractions];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$UsersTableReferences
    extends BaseReferences<_$GeoCityDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserLocationsTable, List<UserLocation>>
      _userLocationsRefsTable(_$GeoCityDatabase db) =>
          MultiTypedResultKey.fromTable(db.userLocations,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.userLocations.userId));

  $$UserLocationsTableProcessedTableManager get userLocationsRefs {
    final manager = $$UserLocationsTableTableManager($_db, $_db.userLocations)
        .filter((f) => f.userId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_userLocationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer
    extends FilterComposer<_$GeoCityDatabase, $UsersTable> {
  $$UsersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter userLocationsRefs(
      ComposableFilter Function($$UserLocationsTableFilterComposer f) f) {
    final $$UserLocationsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.userLocations,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder, parentComposers) =>
            $$UserLocationsTableFilterComposer(ComposerState($state.db,
                $state.db.userLocations, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends OrderingComposer<_$GeoCityDatabase, $UsersTable> {
  $$UsersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$UsersTableTableManager extends RootTableManager<
    _$GeoCityDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool userLocationsRefs})> {
  $$UsersTableTableManager(_$GeoCityDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userLocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userLocationsRefs) db.userLocations
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userLocationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._userLocationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .userLocationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$GeoCityDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool userLocationsRefs})>;
typedef $$UserLocationsTableCreateCompanionBuilder = UserLocationsCompanion
    Function({
  Value<int> id,
  required int userId,
  required jts.Point location,
});
typedef $$UserLocationsTableUpdateCompanionBuilder = UserLocationsCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<jts.Point> location,
});

final class $$UserLocationsTableReferences extends BaseReferences<
    _$GeoCityDatabase, $UserLocationsTable, UserLocation> {
  $$UserLocationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$GeoCityDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.userLocations.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    if ($_item.userId == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id($_item.userId!));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserLocationsTableFilterComposer
    extends FilterComposer<_$GeoCityDatabase, $UserLocationsTable> {
  $$UserLocationsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<jts.Point> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $state.db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$UsersTableFilterComposer(
            ComposerState(
                $state.db, $state.db.users, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$UserLocationsTableOrderingComposer
    extends OrderingComposer<_$GeoCityDatabase, $UserLocationsTable> {
  $$UserLocationsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<jts.Point> get location => $state.composableBuilder(
      column: $state.table.location,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $state.db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$UsersTableOrderingComposer(
            ComposerState(
                $state.db, $state.db.users, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$UserLocationsTableTableManager extends RootTableManager<
    _$GeoCityDatabase,
    $UserLocationsTable,
    UserLocation,
    $$UserLocationsTableFilterComposer,
    $$UserLocationsTableOrderingComposer,
    $$UserLocationsTableCreateCompanionBuilder,
    $$UserLocationsTableUpdateCompanionBuilder,
    (UserLocation, $$UserLocationsTableReferences),
    UserLocation,
    PrefetchHooks Function({bool userId})> {
  $$UserLocationsTableTableManager(
      _$GeoCityDatabase db, $UserLocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserLocationsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserLocationsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<jts.Point> location = const Value.absent(),
          }) =>
              UserLocationsCompanion(
            id: id,
            userId: userId,
            location: location,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required jts.Point location,
          }) =>
              UserLocationsCompanion.insert(
            id: id,
            userId: userId,
            location: location,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserLocationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserLocationsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserLocationsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserLocationsTableProcessedTableManager = ProcessedTableManager<
    _$GeoCityDatabase,
    $UserLocationsTable,
    UserLocation,
    $$UserLocationsTableFilterComposer,
    $$UserLocationsTableOrderingComposer,
    $$UserLocationsTableCreateCompanionBuilder,
    $$UserLocationsTableUpdateCompanionBuilder,
    (UserLocation, $$UserLocationsTableReferences),
    UserLocation,
    PrefetchHooks Function({bool userId})>;
typedef $$TownsTableCreateCompanionBuilder = TownsCompanion Function({
  Value<int> id,
  required String name,
  required jts.Polygon boundary,
});
typedef $$TownsTableUpdateCompanionBuilder = TownsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<jts.Polygon> boundary,
});

class $$TownsTableFilterComposer
    extends FilterComposer<_$GeoCityDatabase, $TownsTable> {
  $$TownsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<jts.Polygon> get boundary => $state.composableBuilder(
      column: $state.table.boundary,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TownsTableOrderingComposer
    extends OrderingComposer<_$GeoCityDatabase, $TownsTable> {
  $$TownsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<jts.Polygon> get boundary => $state.composableBuilder(
      column: $state.table.boundary,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$TownsTableTableManager extends RootTableManager<
    _$GeoCityDatabase,
    $TownsTable,
    Town,
    $$TownsTableFilterComposer,
    $$TownsTableOrderingComposer,
    $$TownsTableCreateCompanionBuilder,
    $$TownsTableUpdateCompanionBuilder,
    (Town, BaseReferences<_$GeoCityDatabase, $TownsTable, Town>),
    Town,
    PrefetchHooks Function()> {
  $$TownsTableTableManager(_$GeoCityDatabase db, $TownsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TownsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TownsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<jts.Polygon> boundary = const Value.absent(),
          }) =>
              TownsCompanion(
            id: id,
            name: name,
            boundary: boundary,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required jts.Polygon boundary,
          }) =>
              TownsCompanion.insert(
            id: id,
            name: name,
            boundary: boundary,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TownsTableProcessedTableManager = ProcessedTableManager<
    _$GeoCityDatabase,
    $TownsTable,
    Town,
    $$TownsTableFilterComposer,
    $$TownsTableOrderingComposer,
    $$TownsTableCreateCompanionBuilder,
    $$TownsTableUpdateCompanionBuilder,
    (Town, BaseReferences<_$GeoCityDatabase, $TownsTable, Town>),
    Town,
    PrefetchHooks Function()>;
typedef $$ParksTableCreateCompanionBuilder = ParksCompanion Function({
  Value<int> id,
  required String name,
  required jts.MultiPolygon areas,
});
typedef $$ParksTableUpdateCompanionBuilder = ParksCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<jts.MultiPolygon> areas,
});

class $$ParksTableFilterComposer
    extends FilterComposer<_$GeoCityDatabase, $ParksTable> {
  $$ParksTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<jts.MultiPolygon> get areas => $state.composableBuilder(
      column: $state.table.areas,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ParksTableOrderingComposer
    extends OrderingComposer<_$GeoCityDatabase, $ParksTable> {
  $$ParksTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<jts.MultiPolygon> get areas => $state.composableBuilder(
      column: $state.table.areas,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$ParksTableTableManager extends RootTableManager<
    _$GeoCityDatabase,
    $ParksTable,
    Park,
    $$ParksTableFilterComposer,
    $$ParksTableOrderingComposer,
    $$ParksTableCreateCompanionBuilder,
    $$ParksTableUpdateCompanionBuilder,
    (Park, BaseReferences<_$GeoCityDatabase, $ParksTable, Park>),
    Park,
    PrefetchHooks Function()> {
  $$ParksTableTableManager(_$GeoCityDatabase db, $ParksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ParksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ParksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<jts.MultiPolygon> areas = const Value.absent(),
          }) =>
              ParksCompanion(
            id: id,
            name: name,
            areas: areas,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required jts.MultiPolygon areas,
          }) =>
              ParksCompanion.insert(
            id: id,
            name: name,
            areas: areas,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ParksTableProcessedTableManager = ProcessedTableManager<
    _$GeoCityDatabase,
    $ParksTable,
    Park,
    $$ParksTableFilterComposer,
    $$ParksTableOrderingComposer,
    $$ParksTableCreateCompanionBuilder,
    $$ParksTableUpdateCompanionBuilder,
    (Park, BaseReferences<_$GeoCityDatabase, $ParksTable, Park>),
    Park,
    PrefetchHooks Function()>;
typedef $$BusRoutesTableCreateCompanionBuilder = BusRoutesCompanion Function({
  Value<int> id,
  required String routeName,
  required jts.MultiLineString path,
});
typedef $$BusRoutesTableUpdateCompanionBuilder = BusRoutesCompanion Function({
  Value<int> id,
  Value<String> routeName,
  Value<jts.MultiLineString> path,
});

class $$BusRoutesTableFilterComposer
    extends FilterComposer<_$GeoCityDatabase, $BusRoutesTable> {
  $$BusRoutesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get routeName => $state.composableBuilder(
      column: $state.table.routeName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<jts.MultiLineString> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BusRoutesTableOrderingComposer
    extends OrderingComposer<_$GeoCityDatabase, $BusRoutesTable> {
  $$BusRoutesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get routeName => $state.composableBuilder(
      column: $state.table.routeName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<jts.MultiLineString> get path => $state.composableBuilder(
      column: $state.table.path,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$BusRoutesTableTableManager extends RootTableManager<
    _$GeoCityDatabase,
    $BusRoutesTable,
    BusRoute,
    $$BusRoutesTableFilterComposer,
    $$BusRoutesTableOrderingComposer,
    $$BusRoutesTableCreateCompanionBuilder,
    $$BusRoutesTableUpdateCompanionBuilder,
    (BusRoute, BaseReferences<_$GeoCityDatabase, $BusRoutesTable, BusRoute>),
    BusRoute,
    PrefetchHooks Function()> {
  $$BusRoutesTableTableManager(_$GeoCityDatabase db, $BusRoutesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BusRoutesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BusRoutesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> routeName = const Value.absent(),
            Value<jts.MultiLineString> path = const Value.absent(),
          }) =>
              BusRoutesCompanion(
            id: id,
            routeName: routeName,
            path: path,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String routeName,
            required jts.MultiLineString path,
          }) =>
              BusRoutesCompanion.insert(
            id: id,
            routeName: routeName,
            path: path,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BusRoutesTableProcessedTableManager = ProcessedTableManager<
    _$GeoCityDatabase,
    $BusRoutesTable,
    BusRoute,
    $$BusRoutesTableFilterComposer,
    $$BusRoutesTableOrderingComposer,
    $$BusRoutesTableCreateCompanionBuilder,
    $$BusRoutesTableUpdateCompanionBuilder,
    (BusRoute, BaseReferences<_$GeoCityDatabase, $BusRoutesTable, BusRoute>),
    BusRoute,
    PrefetchHooks Function()>;
typedef $$TouristAttractionsTableCreateCompanionBuilder
    = TouristAttractionsCompanion Function({
  Value<int> id,
  required String name,
  required jts.MultiPoint locations,
});
typedef $$TouristAttractionsTableUpdateCompanionBuilder
    = TouristAttractionsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<jts.MultiPoint> locations,
});

class $$TouristAttractionsTableFilterComposer
    extends FilterComposer<_$GeoCityDatabase, $TouristAttractionsTable> {
  $$TouristAttractionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<jts.MultiPoint> get locations => $state.composableBuilder(
      column: $state.table.locations,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TouristAttractionsTableOrderingComposer
    extends OrderingComposer<_$GeoCityDatabase, $TouristAttractionsTable> {
  $$TouristAttractionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<jts.MultiPoint> get locations => $state.composableBuilder(
      column: $state.table.locations,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$TouristAttractionsTableTableManager extends RootTableManager<
    _$GeoCityDatabase,
    $TouristAttractionsTable,
    TouristAttraction,
    $$TouristAttractionsTableFilterComposer,
    $$TouristAttractionsTableOrderingComposer,
    $$TouristAttractionsTableCreateCompanionBuilder,
    $$TouristAttractionsTableUpdateCompanionBuilder,
    (
      TouristAttraction,
      BaseReferences<_$GeoCityDatabase, $TouristAttractionsTable,
          TouristAttraction>
    ),
    TouristAttraction,
    PrefetchHooks Function()> {
  $$TouristAttractionsTableTableManager(
      _$GeoCityDatabase db, $TouristAttractionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TouristAttractionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$TouristAttractionsTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<jts.MultiPoint> locations = const Value.absent(),
          }) =>
              TouristAttractionsCompanion(
            id: id,
            name: name,
            locations: locations,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required jts.MultiPoint locations,
          }) =>
              TouristAttractionsCompanion.insert(
            id: id,
            name: name,
            locations: locations,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TouristAttractionsTableProcessedTableManager = ProcessedTableManager<
    _$GeoCityDatabase,
    $TouristAttractionsTable,
    TouristAttraction,
    $$TouristAttractionsTableFilterComposer,
    $$TouristAttractionsTableOrderingComposer,
    $$TouristAttractionsTableCreateCompanionBuilder,
    $$TouristAttractionsTableUpdateCompanionBuilder,
    (
      TouristAttraction,
      BaseReferences<_$GeoCityDatabase, $TouristAttractionsTable,
          TouristAttraction>
    ),
    TouristAttraction,
    PrefetchHooks Function()>;

class $GeoCityDatabaseManager {
  final _$GeoCityDatabase _db;
  $GeoCityDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$UserLocationsTableTableManager get userLocations =>
      $$UserLocationsTableTableManager(_db, _db.userLocations);
  $$TownsTableTableManager get towns =>
      $$TownsTableTableManager(_db, _db.towns);
  $$ParksTableTableManager get parks =>
      $$ParksTableTableManager(_db, _db.parks);
  $$BusRoutesTableTableManager get busRoutes =>
      $$BusRoutesTableTableManager(_db, _db.busRoutes);
  $$TouristAttractionsTableTableManager get touristAttractions =>
      $$TouristAttractionsTableTableManager(_db, _db.touristAttractions);
}
