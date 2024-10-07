import 'package:dart_jts/dart_jts.dart';
import 'package:drift/drift.dart';
import 'package:drift_postgis/drift_postgis.dart';

void main() {}

class DropoffStations extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Column<Point> get location => isPostGIS
  //     ? customType(PointType(srid: 4326))()
  //     : customType(SpatialitePointType(srid: 4326))();
  TextColumn get name => text()();
  Column<Point> get location => customType(PostGISPointType(srid: 4326))();
}

class RiderRoutes extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  Column<LineString> get path =>
      customType(PostGISLineStringType(srid: 4326))();
}

class Towns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<Polygon> get boundary => customType(PostGISPolygonType(srid: 4326))();
}

// @DriftDatabase(tables: [
//   DropoffStations,
//   RiderRoutes,
//   Towns,
// ])
// class RidersDB extends _$RidersDB {}
