import 'package:dart_jts/dart_jts.dart' as jts;
// import 'package:drift/drift.dart';
// import 'package:drift_postgres/drift_postgres.dart';
// import 'package:postgres/postgres.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

import 'database.dart';

void main() {
  late TestDB testDB;
  late User user;
  final gf = jts.GeometryFactory.defaultPrecision();

  setUpAll(() async {
    testDB = TestDB(
      PgDatabase(
        endpoint: Endpoint(
          host: 'localhost',
          database: 'postgres',
          username: 'postgres',
          password: 'postgres',
          port: 5432,
        ),
        enableMigrations: true,
        logStatements: true,
        settings: ConnectionSettings(
          sslMode: SslMode.disable,
        ),
      ),
    );
  });

  setUp(() async {
    user = await testDB.createUser('Douglas');
    addTearDown(() => testDB.deleteUserById(user.id));
  });

  test('can add a user', () async {
    expect(user.id, isNot(0));
  });

  test('can add a location', () async {
    final location = gf.createPoint(jts.Coordinate(1, 2));
    final saved = await testDB.createUserLocation(user.id, location);
    expect(saved, isNot(0));
    addTearDown(() => testDB.deleteUserLocationById(saved.id));
  });

  test('can add a town', () async {
    final boundary =
        gf.createPoint(jts.Coordinate(1, 2)).buffer(0.1) as jts.Polygon;
    final saved = await testDB.createTown('Nairobi', boundary);
    expect(saved, isNot(0));
    expect(saved.boundary.equals(boundary), isTrue);
    addTearDown(() => testDB.deleteTownById(saved.id));
  });

  test('can get users within a town', () async {
    final boundary =
        gf.createPoint(jts.Coordinate(1, 2)).buffer(0.2) as jts.Polygon;
    final town = await testDB.createTown('Nairobi', boundary);
    addTearDown(() => testDB.deleteTownById(town.id));

    final location = gf.createPoint(jts.Coordinate(1, 2));
    final ul = await testDB.createUserLocation(user.id, location);
    expect(ul.location.equals(location), isTrue);
    addTearDown(() => testDB.deleteUserLocationById(ul.id));

    final users = await testDB.getUsersWithinTownId(town.id);
    expect(users, hasLength(1));

    final envelope = boundary.getEnvelopeInternal();

    /// random point within the boundary
    final randomInNairobi = gf.createPoint(jts.Coordinate(
      envelope.getMinX() + (envelope.getWidth() * 0.5),
      envelope.getMinY() + (envelope.getHeight() * 0.5),
    ));

    expect(boundary.contains(randomInNairobi), isTrue);

    final nairobiLocation = await testDB.createUserLocation(
      user.id,
      randomInNairobi,
    );
    addTearDown(() => testDB.deleteUserLocationById(nairobiLocation.id));

    final usersInNairobi = await testDB.getUsersWithinTownId(town.id);
    expect(usersInNairobi, hasLength(2));

    // random point outside the boundary
    final outsideNairobi = gf.createPoint(jts.Coordinate(
      envelope.getMinX() + (envelope.getWidth() * 1.5),
      envelope.getMinY() + (envelope.getHeight() * 1.5),
    ));
    expect(boundary.contains(outsideNairobi), isFalse);

    final outsideUl = await testDB.createUserLocation(user.id, outsideNairobi);
    final usersOutsideNairobi = await testDB.getUsersWithinTownId(town.id);
    expect(usersOutsideNairobi, hasLength(2));
    addTearDown(() => testDB.deleteUserLocationById(outsideUl.id));
  });

  test('can get a town by id', () async {
    final boundary =
        gf.createPoint(jts.Coordinate(1, 2)).buffer(0.2) as jts.Polygon;
    final town = await testDB.createTown('Nairobi', boundary);
    addTearDown(() => testDB.deleteTownById(town.id));

    final savedTown = await testDB.getTownById(town.id);
    expect(savedTown, isNotNull);
    expect(savedTown!.id, equals(town.id));
    expect(savedTown.name, equals(town.name));
    expect(savedTown.boundary.equals(town.boundary), isTrue);
  });

  // test('can get a town as geojson', () async {
  //   final boundary =
  //       gf.createPoint(jts.Coordinate(1, 2)).buffer(0.2) as jts.Polygon;
  //   final town = await testDB.createTown('Nairobi', boundary);
  //   addTearDown(() => testDB.deleteTownById(town.id));

  //   final savedTown = await testDB.getTownAsGeoJson(town.id);
  //   print(savedTown);
  // });
}

// void main() {
//   final gf = jts.GeometryFactory.defaultPrecision();

//   group('Can CRUD', () {
//     late 

//     final admEndpoint = Endpoint(
//       host: 'localhost',
//       database: 'postgres',
//       username: 'postgres',
//       password: 'postgres',
//     );

//     setUp(() async {
//       final connection = await Connection.open(
//         admEndpoint,
//         settings: ConnectionSettings(sslMode: SslMode.disable),
//       );

//       try {
//         await connection.execute('DROP DATABASE akan_dev_db');
//       } catch (_) {
//         print(_);
//       }

//       final result = await connection.execute('CREATE DATABASE akan_dev_db');
//       print(result);

//       akanDB = AkanDB(
//         PgDatabase(
//           endpoint: Endpoint(
//             host: 'localhost',
//             database: 'akan_dev_db',
//             username: 'doug',
//             password: 'doug123',
//           ),
//           logStatements: true,
//           settings: ConnectionSettings(sslMode: SslMode.disable),
//         ),
//       );
//       final migrator = akanDB.createMigrator();
//       await migrator.createAll();
//       requestHandler = UserRequestHandler(akanDB: akanDB);
//     });

//     test('can create user', () async {
//       final saved = await requestHandler.create(
//         User(
//           id: 0,
//           name: 'Douglas',
//           email: 'bettdoug@gmail.com',
//           password: 'password',
//           updatedAt: DateTime.now(),
//         ),
//       );
//       saved.fold((l) => throw l, (r) {
//         expect(r.id, isNot(0));
//       });
//     });

//     test('can add drop off stations', () async {
//       final pt = gf.createPoint(jts.Coordinate(178.6, 78.0));
//       final savedPoint = await akanDB.dropoffStations.insertReturning(
//         DropoffStationsCompanion.insert(
//           location: pt,
//           name: 'Nairobi',
//         ),
//       );
//       expect(savedPoint.location.getX(), equals(pt.getX()));
//       expect(savedPoint.location.getY(), equals(pt.getY()));
//       expect(savedPoint.location.equals(pt), isTrue);
//     });

//     test('can add rider routes', () async {
//       final path = gf.createLineString([
//         jts.Coordinate(178.6, 78.0),
//         jts.Coordinate(178.6, 76.0),
//         jts.Coordinate(178.6, 75.0),
//       ]);
//       final savedRiderRoute = await akanDB.riderRoutes.insertReturning(
//         RiderRoutesCompanion.insert(path: path),
//       );
//       expect(savedRiderRoute.path.equals(path), isTrue);
//     });

//     test('can add kenyan towns', () async {
//       final coordinate = jts.Coordinate(178.6, 78.0);
//       final point = gf.createPoint(coordinate);
//       final boundary = point.buffer(200);

//       final savedPoint = await akanDB.dropoffStations.insertReturning(
//         DropoffStationsCompanion.insert(
//           location: point,
//           name: 'Nairobi',
//         ),
//       );

//       final savedTown = await akanDB.towns.insertReturning(
//         TownsCompanion.insert(
//           name: 'Nairobi Town',
//           boundary: boundary as jts.Polygon,
//         ),
//       );

//       expect(savedTown.boundary.equals(boundary), isTrue);
//     });

//     test('can get stations within a town', () async {
//       final coordinate = jts.Coordinate(1, 2);
//       final point = gf.createPoint(coordinate);
//       final boundary = point.buffer(0.1);

//       final savedPoint = await akanDB.dropoffStations.insertReturning(
//         DropoffStationsCompanion.insert(
//           location: point,
//           name: 'Nairobi',
//         ),
//       );

//       final outside = jts.Coordinate(178.6, 78.0);
//       final outsidePoint = gf.createPoint(outside);
//       expect(boundary.contains(outsidePoint), isFalse);

//       final savedOutsidePoint = await akanDB.dropoffStations.insertReturning(
//         DropoffStationsCompanion.insert(
//           location: outsidePoint,
//           name: 'Outside Nairobi Town',
//         ),
//       );

//       final savedTown = await akanDB.towns.insertReturning(
//         TownsCompanion.insert(
//           name: 'Nairobi Town',
//           boundary: boundary as jts.Polygon,
//         ),
//       );

//       final stationsWithinNairobi = await akanDB.stationsWithinTown(
//         savedTown.id,
//       );

//       expect(stationsWithinNairobi, hasLength(1));
//     });
//   });
// }
