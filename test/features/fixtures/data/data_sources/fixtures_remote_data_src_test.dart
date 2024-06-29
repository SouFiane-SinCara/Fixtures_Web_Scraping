import 'dart:io';

import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';

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
    String testDate = '2024-06-01';
    String dataTest =
        File('test/core/constants/response_data.html').readAsStringSync();
    final successResponse = http.Response('{"data": "sample"}', 200);
    test('should return fixtures models', () async {
      //AAA
      //arrange
      when(mockClient.get(Uri.parse(fixturesUrl))).thenAnswer((_) async {
        return successResponse;
      });
      //act
      final result = await fixturesRemoteDataSource.getFixtures(date: testDate);
      //assert
      expect(result, isA<List<Fixture>>());
    });
    final errorResponse = http.Response('Not Found', 404);
    test('should throw a Exception', () async {
      //AAA
      //arrange
      when(mockClient.get(Uri.parse(fixturesUrl))).thenAnswer((_) async {
        return errorResponse;
      });

      // act then assert
      expect(() async {
        await fixturesRemoteDataSource.getFixtures(date: testDate);
      }, throwsA(isA<Exception>()));
    });
  });
}
