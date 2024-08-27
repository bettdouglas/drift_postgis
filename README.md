<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This package extends drift.dev ecosystem to add support for postgis types. It aims to have a type-safe way of handling geospatial queries

## Features
It currently supports the following geometry types:
- Point
- LineString
- Polygon
- MultiPoint
- MultiLineString
- MultiPolygon
- GeometryCollection

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
class DropoffStations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<Point> get location => customType(PostGISPointType(4326))();
}

class RiderRoutes extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  Column<LineString> get path => customType(PostGISLineStringType(4326))();
}

class Towns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  Column<Polygon> get boundary => customType(PostGISPolygonType(4326))();
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.


## Running tests

```
docker run -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgis/postgis
```