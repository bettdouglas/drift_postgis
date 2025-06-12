import 'package:dart_jts/dart_jts.dart';
import 'package:drift/drift.dart';

// --- Constructor Functions ---

/// Creates a geometry instance from a Well-Known Text representation (WKT).
/// See: https://postgis.net/docs/ST_GeomFromText.html
Expression<Geometry> stGeomFromText(Expression<String> wkt,
    [Expression<int>? srid]) {
  if (srid != null) {
    return FunctionCallExpression('ST_GeomFromText', [wkt, srid]);
  }
  return FunctionCallExpression('ST_GeomFromText', [wkt]);
}

/// Creates a 2D, 3DZ or 4D point geometry.
/// See: https://postgis.net/docs/ST_MakePoint.html
Expression<Point> stMakePoint(Expression<double> x, Expression<double> y,
    [Expression<double>? z, Expression<double>? m]) {
  final args = [x, y];
  if (z != null) {
    args.add(z);
  }
  if (m != null) {
    args.add(m);
  }
  // The return type is Expression<Point> for type safety in Drift,
  // even though PostGIS returns a generic geometry.
  return FunctionCallExpression('ST_MakePoint', args);
}

// --- Geometry Extension ---

/// An extension on [Expression<Geometry>] to provide PostGIS functions.
extension PostGISFunctionExtensions on Expression<Geometry> {
  // --- Relationship Checks ---

  /// Returns true if the given geometries represent the same geometry.
  /// Directionality is ignored.
  /// See: https://postgis.net/docs/ST_Equals.html
  Expression<bool> stEquals(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Equals', [this, other]);
  }

  /// Returns TRUE if the supplied geometries have some, but not all, interior
  /// points in common.
  /// See: https://postgis.net/docs/ST_Crosses.html
  Expression<bool> stCrosses(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Crosses', [this, other]);
  }

  /// Returns TRUE if the Geometries do not “spatially intersect” - if they do
  /// not share any space together.
  /// See: https://postgis.net/docs/ST_Disjoint.html
  Expression<bool> stDisjoint(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Disjoint', [this, other]);
  }

  /// Returns TRUE if the Geometries share space, are of the same dimension, but
  /// are not completely contained by each other.
  /// See: https://postgis.net/docs/ST_Overlaps.html
  Expression<bool> stOverlaps(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Overlaps', [this, other]);
  }

  /// Returns true if the geometry A is completely inside geometry B.
  /// See: https://postgis.net/docs/ST_Within.html
  Expression<bool> stWithin(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Within', [this, other]);
  }

  /// Returns true if and only if no points of B lie in the exterior of A,
  /// and at least one point of the interior of B lies in the interior of A.
  /// See: https://postgis.net/docs/ST_Contains.html
  Expression<bool> stContains(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Contains', [this, other]);
  }

  /// Returns TRUE if the geometries have at least one point in common, but their
  /// interiors do not intersect.
  /// See: https://postgis.net/docs/ST_Touches.html
  Expression<bool> stTouches(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Touches', [this, other]);
  }

  /// Returns TRUE if the Geometries/Geography “spatially intersect”.
  /// See: https://postgis.net/docs/ST_Intersects.html
  Expression<bool> stIntersects(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Intersects', [this, other]);
  }

  /// Returns true if no point of geom B is outside geom A.
  /// See: https://postgis.net/docs/ST_Covers.html
  Expression<bool> stCovers(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Covers', [this, other]);
  }

  /// Returns true if no point of geom A is outside geom B.
  /// See: https://postgis.net/docs/ST_CoveredBy.html
  Expression<bool> stCoveredBy(Expression<Geometry> other) {
    return FunctionCallExpression('ST_CoveredBy', [this, other]);
  }

  // --- Distance and Measurement ---

  /// Returns true if the geometries are within the specified distance (radius)
  /// of one another. For geometry, distance is in units of the spatial
  /// reference system.
  /// See: https://postgis.net/docs/ST_DWithin.html
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

  /// Returns the 2D cartesian distance between two geometries in projected units.
  /// See: https://postgis.net/docs/ST_Distance.html
  Expression<double> stDistance(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Distance', [this, other]);
  }

  /// Returns the area of the geometry if it is a polygon or multi-polygon.
  /// See: https://postgis.net/docs/ST_Area.html
  Expression<double> stArea() {
    return FunctionCallExpression('ST_Area', [this]);
  }

  /// Returns the length of the geometry if it is a linestring or multi-linestring.
  /// See: https://postgis.net/docs/ST_Length.html
  Expression<double> stLength() {
    return FunctionCallExpression('ST_Length', [this]);
  }

  // --- Geometry Processing ---

  /// Returns a geometry that represents all points whose distance from this
  /// Geometry is less than or equal to distance.
  /// See: https://postgis.net/docs/ST_Buffer.html
  Expression<Geometry> stBuffer(Expression<double> radius, [String? options]) {
    final args = <Expression>[this, radius];
    if (options != null) {
      args.add(Constant(options));
    }
    return FunctionCallExpression('ST_Buffer', args);
  }

  /// Returns the geometric center of a geometry.
  /// See: https://postgis.net/docs/ST_Centroid.html
  Expression<Point> stCentroid() {
    return FunctionCallExpression('ST_Centroid', [this]);
  }

  /// Returns a new geometry with its coordinates transformed to a different
  /// spatial reference system.
  /// See: https://postgis.net/docs/ST_Transform.html
  Expression<Geometry> stTransform(Expression<int> srid) {
    return FunctionCallExpression('ST_Transform', [this, srid]);
  }

  /// Returns a "simplified" version of the given geometry using the
  /// Douglas-Peucker algorithm.
  /// See: https://postgis.net/docs/ST_Simplify.html
  Expression<Geometry> stSimplify(Expression<double> tolerance) {
    return FunctionCallExpression('ST_Simplify', [this, tolerance]);
  }

  /// Returns a geometry that represents the point set union of the Geometries.
  /// See: https://postgis.net/docs/ST_Union.html
  Expression<Geometry> stUnion(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Union', [this, other]);
  }

  /// Returns a geometry that represents the point set intersection of the
  /// two Geometries.
  /// See: https://postgis.net/docs/ST_Intersection.html
  Expression<Geometry> stIntersection(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Intersection', [this, other]);
  }

  /// Returns a geometry that represents that part of geometry A that does not
  /// intersect with geometry B.
  /// See: https://postgis.net/docs/ST_Difference.html
  Expression<Geometry> stDifference(Expression<Geometry> other) {
    return FunctionCallExpression('ST_Difference', [this, other]);
  }

  /// Returns the bounding box of the geometry.
  /// See: https://postgis.net/docs/ST_Envelope.html
  Expression<Geometry> stEnvelope() {
    return FunctionCallExpression('ST_Envelope', [this]);
  }

  // --- Geometry Accessors ---

  /// Returns the Well-Known Text (WKT) representation of the geometry.
  /// See: https://postgis.net/docs/ST_AsText.html
  Expression<String> stAsText() {
    return FunctionCallExpression('ST_AsText', [this]);
  }

  /// Returns the GeoJSON representation of the geometry.
  /// See: https://postgis.net/docs/ST_AsGeoJSON.html
  Expression<String> stAsGeoJSON() {
    return FunctionCallExpression('ST_AsGeoJSON', [this]);
  }

  /// Returns the number of points in the geometry.
  /// See: https://postgis.net/docs/ST_NPoints.html
  Expression<int> stNPoints() {
    return FunctionCallExpression('ST_NPoints', [this]);
  }

  /// Returns the X coordinate of a point, or NULL if not a point.
  /// See: https://postgis.net/docs/ST_X.html
  Expression<double> stX() {
    return FunctionCallExpression('ST_X', [this]);
  }

  /// Returns the Y coordinate of a point, or NULL if not a point.
  /// See: https://postgis.net/docs/ST_Y.html
  Expression<double> stY() {
    return FunctionCallExpression('ST_Y', [this]);
  }

  /// Returns the Z coordinate of a point, or NULL if not a point or doesn't have a Z coordinate.
  /// See: https://postgis.net/docs/ST_Z.html
  Expression<double> stZ() {
    return FunctionCallExpression('ST_Z', [this]);
  }

  /// Returns the spatial reference identifier (SRID) for the geometry.
  /// See: https://postgis.net/docs/ST_SRID.html
  Expression<int> stSrid() {
    return FunctionCallExpression('ST_SRID', [this]);
  }

  /// Returns the type of the geometry as a string. E.g. 'ST_Linestring', 'ST_Polygon', etc.
  /// See: https://postgis.net/docs/GeometryType.html
  Expression<String> stGeometryType() {
    return FunctionCallExpression('GeometryType', [this]);
  }

  /// Returns true if the geometry is valid.
  /// See: https://postgis.net/docs/ST_IsValid.html
  Expression<bool> stIsValid() {
    return FunctionCallExpression('ST_IsValid', [this]);
  }

  /// Returns the first point of a LINESTRING geometry as a POINT.
  /// See: https://postgis.net/docs/ST_StartPoint.html
  Expression<Point> stStartPoint() {
    return FunctionCallExpression('ST_StartPoint', [this]);
  }

  /// Returns the last point of a LINESTRING geometry as a POINT.
  /// See: https://postgis.net/docs/ST_EndPoint.html
  Expression<Point> stEndPoint() {
    return FunctionCallExpression('ST_EndPoint', [this]);
  }

  /// Returns TRUE if a LINESTRING's start and end points are coincident.
  /// See: https://postgis.net/docs/ST_IsClosed.html
  Expression<bool> stIsClosed() {
    return FunctionCallExpression('ST_IsClosed', [this]);
  }

  /// Returns TRUE if this LINESTRING is both closed and simple.
  /// See: https://postgis.net/docs/ST_IsRing.html
  Expression<bool> stIsRing() {
    return FunctionCallExpression('ST_IsRing', [this]);
  }

  /// If the geometry is a collection, returns the number of geometries.
  /// See: https://postgis.net/docs/ST_NumGeometries.html
  Expression<int> stNumGeometries() {
    return FunctionCallExpression('ST_NumGeometries', [this]);
  }

  /// If the geometry is a collection, returns the Nth geometry.
  /// See: https://postgis.net/docs/ST_GeometryN.html
  Expression<Geometry> stGeometryN(Expression<int> n) {
    return FunctionCallExpression('ST_GeometryN', [this, n]);
  }

  /// Sets the SRID on a geometry to a particular integer value.
  /// See: https://postgis.net/docs/ST_SetSRID.html
  Expression<Geometry> stSetSrid(Expression<int> srid) {
    return FunctionCallExpression('ST_SetSRID', [this, srid]);
  }
}

/// Standalone function to read WKT. This is a Dart-side operation, not a SQL one.
/// It remains here for utility.
Geometry geomFromText(String text) {
  final geometry = WKTReader().read(text);
  if (geometry == null) {
    throw Exception('Failed to read $text');
  }
  return geometry;
}
