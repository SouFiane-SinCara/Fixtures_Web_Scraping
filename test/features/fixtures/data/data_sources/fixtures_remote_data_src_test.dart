import 'dart:io';

import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';

import '../../../../core/constants/web_src.dart';
import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late http.Client mockClient;
  late FixturesRemoteDataSource fixturesRemoteDataSource;
  group('get fixtures remotely', () {
    setUp(() {
      mockClient = MockClient();
      fixturesRemoteDataSource =
          FixturesRemoteDataSourceWebScrapping(httpClient: mockClient);
    });
    String testDate = '2024-06-01';

    final successResponse = http.Response('data:{}', 200);
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
  String testFixtureDetailsUrl = '/109324';
  group(
    'get fixture Details remotely ',
    () {
      final successResponse = http.Response('data:{}', 200);

      test(
        'should return fixture details',
        () async {
          ///AAA
          ///arrange
          when(mockClient.get(Uri.parse(testFixtureDetailsUrl))).thenAnswer(
            (realInvocation) async {
              return successResponse;
            },
          );

          ///act
          final result = await fixturesRemoteDataSource.getFixtureDetails(
              fixtureDetailsUrl: testFixtureDetailsUrl);

          ///assert
          expect(result, isA<FixtureDetails>());
        },
      );
      final errorResponse = http.Response('Not Found', 404);

      test(
        'should throw exception',
        () async {
          ///AAA
          ///arrange
          when(mockClient.get(Uri.parse(testFixtureDetailsUrl))).thenAnswer(
            (realInvocation) async {
              return errorResponse;
            },
          );

          ///act
          final result = await fixturesRemoteDataSource.getFixtureDetails(
              fixtureDetailsUrl: testFixtureDetailsUrl);

          ///assert
          expect(result, isA<Exception>());
        },
      );
    },
  );
}
