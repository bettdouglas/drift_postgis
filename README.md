# drift_postgis

drift_postgis is a Dart package that extends the Drift ORM to work with PostGIS, allowing you to easily incorporate geospatial data and queries in your Dart applications.

## Getting started

### Prerequisites

- Dart SDK
- PostgreSQL with PostGIS extension
- Drift package

### Installation

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  drift: ^2.8.0
  drift_postgis: ^1.0.0
```

Then run:

```
dart pub get
```

## Usage

drift_postgis provides custom column types and functions to work with PostGIS geometries in Drift. Here's an example of how to use it in a project like GeoCity in the `example/geocity` folder:

### Defining Tables with Geometry Columns

```dart
import 'package:drift/drift.dart';
import 'package:drift_postgis/drift_postgis.dart';

class Towns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<Polygon> get boundary => customType(PostGISPolygonType(4326))();
}

class Parks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<MultiPolygon> get areas => customType(PostGISMultiPolygonType(4326))();
}

class BusRoutes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get routeName => text()();
  Column<MultiLineString> get path => customType(PostGISMultiLineStringType(4326))();
}
```

### Using Spatial Queries

```dart
import 'package:drift_postgis/drift_postgis.dart';

class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

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
}
```

These examples demonstrate how to define tables with geometry columns and perform spatial queries using the drift_postgis package.

For more detailed examples, please refer to the `/example` folder in the package repository.

## Additional information

### Supported Geometry Types

drift_postgis supports the following PostGIS geometry types:

- Point
- LineString
- Polygon
- MultiPoint
- MultiLineString
- MultiPolygon

### Spatial Functions

The package provides various spatial functions including:

- stIntersects
- stContains
- stWithin
- stDistance

For a complete list of supported functions, please refer to the API documentation.

### Contributing

Contributions to drift_postgis are welcome! Please feel free to submit a Pull Request.

### Issues

If you discover any bugs or have feature requests, please file an issue on the [issue tracker](link-to-your-issue-tracker).

## Running tests

To run the tests for your project using drift_postgis, you need to have a PostgreSQL instance with PostGIS extension. You can easily set this up using Docker:

```
docker run -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgis/postgis
```

Once the database is running, you can execute the tests using:

```
dart test
```

