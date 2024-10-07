// Drift database for PostGIS tests

import 'package:dart_jts/dart_jts.dart' as jts;
import 'package:drift/drift.dart';
import 'package:drift_postgis/drift_postgis.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class UserLocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  Column<jts.Point> get location => customType(PostGISPointType(srid: 4326))();
}

class Towns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<jts.Polygon> get boundary =>
      customType(PostGISPolygonType(srid: 4326))();
}

@DriftDatabase(
  tables: [
    Users,
    UserLocations,
    Towns,
  ],
)
class TestDB extends _$TestDB {
  TestDB(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.database.customStatement(
          'CREATE EXTENSION IF NOT EXISTS POSTGIS',
        );
        await m.createAll();
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from == 1) {
          await m.createTable(towns);
        }
      },
    );
  }

  Future<List<User>> getUsers() => select(users).get();

  Future<User> createUser(String name) =>
      into(users).insertReturning(UsersCompanion.insert(name: name));

  /// delete a user by id
  Future<void> deleteUserById(int id) {
    return (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<UserLocation> createUserLocation(int userId, jts.Point location) {
    return into(userLocations).insertReturning(
      UserLocationsCompanion.insert(userId: userId, location: location),
    );
  }

  /// delete a location by id
  Future<void> deleteUserLocationById(int id) {
    return (delete(userLocations)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<UserLocation>> getUserLocations() => select(userLocations).get();

  Future<List<Town>> getTowns() => select(towns).get();

  Future<Town> createTown(String name, jts.Polygon boundary) {
    return into(towns).insertReturning(
      TownsCompanion.insert(name: name, boundary: boundary),
    );
  }

  /// get a town by id
  Future<Town?> getTownById(int id) {
    return (select(towns)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// delete a town by id
  Future<void> deleteTownById(int id) {
    return (delete(towns)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<User>> getUsersWithinTownId(int townId) {
    // return select(towns)
    final q = select(users).join([
      innerJoin(
        userLocations,
        userLocations.userId.equalsExp(users.id),
        useColumns: false,
      ),
      innerJoin(
        towns,
        towns.boundary.stContains(userLocations.location),
        useColumns: false,
      ),
    ])
      ..where(towns.id.equals(townId));
    return q.map((p0) => p0.readTable(users)).get();
  }
}
