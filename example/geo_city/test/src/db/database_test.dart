import 'package:dart_jts/dart_jts.dart' as jts;
import 'package:drift_postgres/drift_postgres.dart';
import 'package:geo_city/src/db/database.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

void main() {
  late GeoCityDatabase database;
  late User user;
  final gf = jts.GeometryFactory.defaultPrecision();

  setUpAll(() async {
    database = GeoCityDatabase(
      PgDatabase(
        endpoint: Endpoint(
          host: 'localhost',
          database: 'postgres',
          username: 'postgres',
          password: 'postgres',
        ),
        logStatements: true,
        settings: const ConnectionSettings(
          sslMode: SslMode.disable,
        ),
      ),
    );
  });

  setUp(() async {
    user = await database.createUser('Douglas');
    addTearDown(() => database.deleteUserById(user.id));
  });

  test('can add a park', () async {
    final areas = gf.createMultiPolygon([
      gf.createPoint(jts.Coordinate(1, 1)).buffer(0.1) as jts.Polygon,
      gf.createPoint(jts.Coordinate(2, 2)).buffer(0.2) as jts.Polygon,
    ]);
    final saved = await database.createPark('Central Park', areas);
    expect(saved.id, isNot(0));
    expect(saved.areas.equals(areas), isTrue);
    addTearDown(() => database.deleteParkById(saved.id));
  });

  test('can get parks intersecting a town', () async {
    final townBoundary =
        gf.createPoint(jts.Coordinate(0, 0)).buffer(1) as jts.Polygon;
    final town = await database.createTown('Test Town', townBoundary);
    addTearDown(() => database.deleteTownById(town.id));

    final parkAreas = gf.createMultiPolygon([
      gf.createPoint(jts.Coordinate(0.5, 0.5)).buffer(0.1) as jts.Polygon,
      gf.createPoint(jts.Coordinate(2, 2)).buffer(0.2) as jts.Polygon,
    ]);
    final park = await database.createPark('Test Park', parkAreas);
    addTearDown(() => database.deleteParkById(park.id));

    final intersectingParks = await database.getParksIntersectingTown(town.id);
    expect(intersectingParks, hasLength(1));
    expect(intersectingParks.first.id, equals(park.id));
  });

  test('can add a bus route', () async {
    final path = gf.createMultiLineString([
      gf.createLineString([
        jts.Coordinate(0, 0),
        jts.Coordinate(1, 1),
        jts.Coordinate(2, 2),
      ]),
      gf.createLineString([
        jts.Coordinate(2, 2),
        jts.Coordinate(3, 3),
        jts.Coordinate(4, 4),
      ]),
    ]);
    final saved = await database.createBusRoute('Route 1', path);
    expect(saved.id, isNot(0));
    expect(saved.path.equals(path), isTrue);
    addTearDown(() => database.deleteBusRouteById(saved.id));
  });

  test('can get bus routes intersecting a town', () async {
    final townBoundary =
        gf.createPoint(jts.Coordinate(0, 0)).buffer(2) as jts.Polygon;
    final town = await database.createTown('Test Town', townBoundary);
    addTearDown(() => database.deleteTownById(town.id));

    final routePath = gf.createMultiLineString([
      gf.createLineString([
        jts.Coordinate(-1, -1),
        jts.Coordinate(0, 0),
        jts.Coordinate(1, 1),
      ]),
      gf.createLineString([
        jts.Coordinate(1, 1),
        jts.Coordinate(2, 2),
        jts.Coordinate(3, 3),
      ]),
    ]);
    final route = await database.createBusRoute('Test Route', routePath);
    addTearDown(() => database.deleteBusRouteById(route.id));

    final intersectingRoutes =
        await database.getBusRoutesIntersectingTown(town.id);
    expect(intersectingRoutes, hasLength(1));
    expect(intersectingRoutes.first.id, equals(route.id));
  });

  test('can add a tourist attraction', () async {
    final locations = gf.createMultiPoint(
      [
        jts.Coordinate(1, 1),
        jts.Coordinate(2, 2),
        jts.Coordinate(3, 3),
      ].map(gf.createPoint).toList(),
    );
    final saved =
        await database.createTouristAttraction('Famous Spots', locations);
    expect(saved.id, isNot(0));
    expect(saved.locations.equals(locations), isTrue);
    addTearDown(() => database.deleteTouristAttractionById(saved.id));
  });

  test('can get tourist attractions within a town', () async {
    final townBoundary =
        gf.createPoint(jts.Coordinate(0, 0)).buffer(3) as jts.Polygon;
    final town = await database.createTown('Test Town', townBoundary);
    addTearDown(() => database.deleteTownById(town.id));

    final attractionLocations = gf.createMultiPoint(
      [
        jts.Coordinate(1, 1),
        jts.Coordinate(2, 2),
        jts.Coordinate(4, 4),
      ].map(gf.createPoint).toList(),
    );
    final attraction = await database.createTouristAttraction(
      'Test Attractions',
      attractionLocations,
    );
    addTearDown(() => database.deleteTouristAttractionById(attraction.id));

    final attractionsInTown =
        await database.getTouristAttractionsWithinTown(town.id);
    expect(attractionsInTown, hasLength(1));
    expect(attractionsInTown.first.id, equals(attraction.id));
  });
}
