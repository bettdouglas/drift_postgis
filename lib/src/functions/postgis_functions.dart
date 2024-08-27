import 'package:dart_jts/dart_jts.dart';
import 'package:drift/drift.dart';

/// A list of
extension PostGISFunctionExtensions on Expression<Geometry> {
  /// Returns true if the given geometries represent the same geometry. Directionality is ignored.
  Expression<bool> stEquals(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Equals', [this, other]);
  }

  /// Returns TRUE if the supplied geometries have some, but not all, interior points in common.
  Expression<bool> stCrosses(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Crosses', [this, other]);
  }

  /// Returns TRUE if the Geometries do not “spatially intersect” - if they do not share any space together.
  Expression<bool> stDisjoint(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Disjoint', [this, other]);
  }

  /// Returns TRUE if the Geometries share space, are of the same dimension, but are not completely contained by each other.
  Expression<bool> stOverlaps(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Overlaps', [this, other]);
  }

  /// Returns true if the geometry A is completely inside geometry B
  Expression<bool> stWithin(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Within', [this, other]);
  }

  /// Returns true if and only if no points of B lie in the exterior of A,
  /// and at least one point of the interior of B lies in the interior of A.
  Expression<bool> stContains(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Contains', [this, other]);
  }

  /// Returns TRUE if the geometries have at least one point in common, but their interiors do not intersect.
  Expression<bool> stTouches(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Touches', [this, other]);
  }

  /// Returns TRUE if the Geometries/Geography “spatially intersect” - (share any portion of space) and FALSE if they don’t (they are Disjoint).
  Expression<bool> stIntersects(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Intersects', [this, other]);
  }

  /// Returns true if the geometries are within the specified distance (radius) of one another.
  Expression<bool> stDWithin(Expression<Geometry> other, double distance) {
    return FunctionCallExpression(
      'ST_DWithin',
      [
        this,
        other,
        Constant(distance),
      ],
    );
  }

  /// Returns the 2-dimensional cartesian minimum distance (based on spatial ref) between two geometries in projected units.
  Expression<double> stDistance(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Distance', [this, other]);
  }

  /// Returns the WKT Representation of a geometry
  Expression<String> stAsText() {
    return FunctionCallExpression('ST_AsText', [this]);
  }

  /// Returns the area of the geometry
  Expression<double> stArea() {
    return FunctionCallExpression('ST_Area', [this]);
  }

  /// Returns the bounding box of the geometry
  Expression<Geometry> stEnvelope() {
    return FunctionCallExpression('ST_Envelope', [this]);
  }

  /// Returns the length of the geometry
  Expression<double> stLength() {
    return FunctionCallExpression('ST_Length', [this]);
  }

  // Expression<CustomSqlType<Object>> stAsGeoJson() {
  //   return FunctionCallExpression('ST_AsGeoJSON', [this]);
  // }

  /// Returns the number of points in the geometry
  Expression<int> stNumPoints() {
    return FunctionCallExpression('ST_NumPoints', [this]);
  }

  /// Returns the X coordinate of the point, or NULL if not available.
  Expression<double> stX() {
    return FunctionCallExpression('ST_X', [this]);
  }

  /// Returns the Y coordinate of the point, or NULL if not available.
  Expression<double> stY() {
    return FunctionCallExpression('ST_Y', [this]);
  }
}

Geometry geomFromText(String text) {
  final geometry = WKTReader().read(text);
  if (geometry == null) {
    throw Exception('Failed to read $text');
  }
  return geometry;
}
