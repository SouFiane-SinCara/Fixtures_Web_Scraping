import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../core/constants/web_src.dart';
import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late http.Client mockClient;
  late FixturesRemoteDataSource fixturesRemoteDataSource;
  group('get fixtures from web', () {
    setUp(() {
      mockClient = MockClient();
      fixturesRemoteDataSource =
          FixturesRemoteDataSourceWebScrapping(httpClient: mockClient);
    });
    String testDate = '2024-06-25';

    final successResponse = http.Response('{"data": "sample"}', 200);
    test('should return fixtures models', () async {
      //AAA
      //arrange
      when(await mockClient.get(Uri.parse(fixturesUrl))).thenAnswer((_) {
        return successResponse;
      });
      //act
      final result = await fixturesRemoteDataSource.getFixtures(date: testDate);
      //assert
      expect(result, isA<List<Fixture>>());
    });
    final errorResponse = http.Response('Not Found', 404);
    test('should return a Exception', () async {
      //AAA
      //arrange
      when(await mockClient.get(Uri.parse(fixturesUrl))).thenAnswer((_) {
        return errorResponse;
      });
      //act
      final result = await fixturesRemoteDataSource.getFixtures(date: testDate);
      //assert
      expect(result, isA<Exception>());
    });
  });
}
