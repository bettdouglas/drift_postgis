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

class Parks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<jts.MultiPolygon> get areas =>
      customType(PostGISMultiPolygonType(srid: 4326))();
}

class BusRoutes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get routeName => text()();
  Column<jts.MultiLineString> get path =>
      customType(PostGISMultiLineStringType(srid: 4326))();
}

class TouristAttractions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<jts.MultiPoint> get locations =>
      customType(PostGISMultiPointType(srid: 4326))();
}

@DriftDatabase(
  tables: [
    Users,
    UserLocations,
    Towns,
    Parks,
    BusRoutes,
    TouristAttractions,
  ],
)
class GeoCityDatabase extends _$GeoCityDatabase {
  GeoCityDatabase(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.database.customStatement(
          'CREATE EXTENSION IF NOT EXISTS POSTGIS',
        );
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from == 1) {
          await m.createTable(parks);
          await m.createTable(busRoutes);
          await m.createTable(touristAttractions);
        }
      },
    );
  }

  Future<List<User>> getUsers() => select(users).get();

  Future<User> createUser(String name) =>
      into(users).insertReturning(UsersCompanion.insert(name: name));

  Future<void> deleteUserById(int id) {
    return (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<UserLocation> createUserLocation(int userId, jts.Point location) {
    return into(userLocations).insertReturning(
      UserLocationsCompanion.insert(userId: userId, location: location),
    );
  }

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

  Future<Town?> getTownById(int id) {
    return (select(towns)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> deleteTownById(int id) {
    return (delete(towns)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<User>> getUsersWithinTownId(int townId) {
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

  // New methods for Parks table
  Future<Park> createPark(String name, jts.MultiPolygon areas) {
    return into(parks).insertReturning(
      ParksCompanion.insert(name: name, areas: areas),
    );
  }

  Future<List<Park>> getParksIntersectingTown(int townId) {
    final q = select(parks).join([
      innerJoin(
        towns,
        towns.boundary.stIntersects(parks.areas),
        useColumns: false,
      ),
    ])
      ..where(towns.id.equals(townId));
    return q.map((p0) => p0.readTable(parks)).get();
  }

  // New methods for BusRoutes table
  Future<BusRoute> createBusRoute(String routeName, jts.MultiLineString path) {
    return into(busRoutes).insertReturning(
      BusRoutesCompanion.insert(routeName: routeName, path: path),
    );
  }

  Future<List<BusRoute>> getBusRoutesIntersectingTown(int townId) {
    final q = select(busRoutes).join([
      innerJoin(
        towns,
        towns.boundary.stIntersects(busRoutes.path),
        useColumns: false,
      ),
    ])
      ..where(towns.id.equals(townId));
    return q.map((p0) => p0.readTable(busRoutes)).get();
  }

  // New methods for TouristAttractions table
  Future<TouristAttraction> createTouristAttraction(
    String name,
    jts.MultiPoint locations,
  ) {
    return into(touristAttractions).insertReturning(
      TouristAttractionsCompanion.insert(name: name, locations: locations),
    );
  }

  Future<List<TouristAttraction>> getTouristAttractionsWithinTown(int townId) {
    final q = select(touristAttractions).join([
      innerJoin(
        towns,
        towns.boundary.stContains(touristAttractions.locations),
        useColumns: false,
      ),
    ])
      ..where(towns.id.equals(townId));
    return q.map((p0) => p0.readTable(touristAttractions)).get();
  }

  /// Delete a park by id
  Future<void> deleteParkById(int id) {
    return (delete(parks)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Delete a bus route by id
  Future<void> deleteBusRouteById(int id) {
    return (delete(busRoutes)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Delete a tourist attraction by id
  Future<void> deleteTouristAttractionById(int id) {
    return (delete(touristAttractions)..where((tbl) => tbl.id.equals(id))).go();
  }
}
