import 'package:dart_jts/dart_jts.dart';
import 'package:drift/drift.dart';
import 'package:postgres/postgres.dart' hide Point, Polygon;

import 'utils/parsers.dart';

final _wkbWriter = WKBWriter();

extension _WKBGeometryWriter on Geometry {
  List<int> asWKB() {
    return _wkbWriter.write(this);
  }
}

final _binaryParser = BinaryParser();

/// Represents the PostGIS Geometry type
class PostGISGeometryType implements CustomSqlType<Geometry> {
  /// Constructs a PostGIS Geometry type with the specified [srid]
  PostGISGeometryType(this.srid);

  /// the SRID of the geometry column
  int? srid;

  @override
  String mapToSqlLiteral(Geometry dartValue) {
    return dartValue.toText();
  }

  @override
  Object mapToSqlParameter(Geometry dartValue) {
    return dartValue.asWKB();
  }

  @override
  Geometry read(Object fromSql) {
    final bytes = fromSql as UndecodedBytes;

    final geometry = _binaryParser.parse(bytes.bytes);
    return geometry;
  }

  @override
  String sqlTypeName(GenerationContext context) {
    // late String geometryType;
    // if (T is Point) {
    //   geometryType = 'Point';
    // } else if (T is Polygon) {
    //   geometryType = 'Polygon';
    // } else if (T is LineString) {
    //   geometryType = 'LineString';
    // } else if (T is MultiPoint) {
    //   geometryType = 'MultiPoint';
    // } else if (T is MultiPolygon) {
    //   geometryType = 'MultiPolygon';
    // } else if (T is MultiLineString) {
    //   geometryType = 'MultiLineString';
    // } else if (T is GeometryCollection) {
    //   geometryType = 'GeometryCollection';
    // }
    if (srid == null) {
      return 'GEOMETRY(geometry)';
    } else {
      return 'GEOMETRY(geometry,$srid)';
    }
  }
}

/// Represents the PostGIS Point type
class PostGISPointType implements CustomSqlType<Point> {
  /// Defines a Column with custom SRID
  PostGISPointType(this.srid);

  ///  the SRID
  final int? srid;

  @override
  String mapToSqlLiteral(Point dartValue) {
    return dartValue.toText();
  }

  @override
  Object mapToSqlParameter(Point dartValue) {
    return dartValue.asWKB();
  }

  @override
  Point read(Object fromSql) {
    final bytes = fromSql as UndecodedBytes;

    final point = _binaryParser.parse(bytes.bytes);
    return point as Point;
  }

  @override
  String sqlTypeName(GenerationContext context) {
    return 'GEOMETRY(Point,$srid)';
  }
}

/// Represents the PostGIS Point type
class PostGISPolygonType implements CustomSqlType<Polygon> {
  /// A PostGIS Polygon defined with a specific SRID
  PostGISPolygonType(this.srid);

  /// the SRID
  final int? srid;

  @override
  String mapToSqlLiteral(Polygon dartValue) {
    return dartValue.toText();
  }

  @override
  Object mapToSqlParameter(Polygon dartValue) {
    return dartValue.asWKB();
  }

  @override
  Polygon read(Object fromSql) {
    final bytes = fromSql as UndecodedBytes;

    final polygon = _binaryParser.parse(bytes.bytes);
    return polygon as Polygon;
  }

  @override
  String sqlTypeName(GenerationContext context) {
    return 'Geometry(Polygon,$srid)';
  }
}

/// Models the PostGIS LineString type
class PostGISLineStringType implements CustomSqlType<LineString> {
  /// Defines a custom PostGIS LineString with a specific ID
  PostGISLineStringType(this.srid);

  /// the SRID
  final int? srid;

  @override
  String mapToSqlLiteral(LineString dartValue) {
    return dartValue.toText();
  }

  @override
  Object mapToSqlParameter(LineString dartValue) {
    return dartValue.asWKB();
  }

  @override
  LineString read(Object fromSql) {
    final bytes = fromSql as UndecodedBytes;

    final linestring = _binaryParser.parse(bytes.bytes);
    return linestring as LineString;
  }

  @override
  String sqlTypeName(GenerationContext context) {
    return 'Geometry(LineString,$srid)';
  }
}
