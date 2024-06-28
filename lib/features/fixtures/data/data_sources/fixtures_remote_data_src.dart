import 'package:http/http.dart' as http;

import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';

abstract class FixturesRemoteDataSource {
  Future<List<Fixture>> getFixtures({String? date});
}

class FixturesRemoteDataSourceWebScrapping extends FixturesRemoteDataSource {
  http.Client httpClient;
  FixturesRemoteDataSourceWebScrapping({
    required this.httpClient,
  });

  @override
  Future<List<Fixture>> getFixtures({String? date}) {
    throw UnimplementedError();
  }
}
