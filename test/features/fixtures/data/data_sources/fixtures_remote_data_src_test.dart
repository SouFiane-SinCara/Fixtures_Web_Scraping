import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fixtures_app/core/constants/web_const.dart';
import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late http.Client mockClient;
  late FixturesRemoteDataSourceWebScrapping fixturesRemoteDataSource;
  late Connectivity mockConnectivity;
  setUp(() {
    mockClient = MockClient();
    mockConnectivity = MockConnectivity();
    fixturesRemoteDataSource = FixturesRemoteDataSourceWebScrapping(
        httpClient: mockClient, connectivity: mockConnectivity);
  });
  group('get fixtures remotely', () {
    String testDate = '2024-06-01';
    final successResponse = http.Response('{"data": []}', 200);

    test('should return fixtures models', () async {
      // Arrange
      when(mockClient.get(Uri.parse(fixturesUrl))).thenAnswer((_) async {
        return successResponse;
      });
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async {
          return [ConnectivityResult.wifi];
        },
      );
      // Act
      final result = await fixturesRemoteDataSource.getFixtures(date: testDate);

      // Assert
      expect(result, isA<List<Fixture>>());
    });

    final errorResponse = http.Response('Not Found', 404);

    test('should throw an Exception', () async {
      // Arrange
      when(mockClient.get(Uri.parse(fixturesUrl))).thenAnswer((_) async {
        return errorResponse;
      });
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async {
          return [ConnectivityResult.wifi];
        },
      );
      // Act & Assert
      expect(() async {
        await fixturesRemoteDataSource.getFixtures(date: testDate);
      }, throwsA(isA<ServerException>()));
    });
    test(
      'should throw No internet exception',
      () async {
        //AAA
        //arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer(
          (realInvocation) async {
            return [ConnectivityResult.none];
          },
        );
        //act and assert
        expect(
            () async =>
                await fixturesRemoteDataSource.getFixtures(date: testDate),
            throwsA(isA<NoInternetConnectionException>()));
      },
    );
  });

  String testFixtureDetailsUrl = 'https://onefootball.com/en/match/2470856';

  group('get fixture details remotely', () {
    test('should return fixture details', () async {
      // Arrange
      final response =
          await File('test/core/constants/fixture_details_response.html')
              .readAsBytesSync();
      final successResponse = http.Response.bytes(response, 200);
      when(mockClient.get(Uri.parse(testFixtureDetailsUrl)))
          .thenAnswer((_) async {
        return successResponse;
      });
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async {
          return [ConnectivityResult.wifi];
        },
      );
      when(mockClient.get(Uri.parse(
              'https://onefootball.com//en/competition/copa-america-37/table')))
          .thenAnswer((_) async {
        return successResponse;
      });
      when(mockClient.get(Uri.parse(
              'https://onefootball.com//en/competition/copa-america-37/kotree')))
          .thenAnswer((_) async {
        return successResponse;
      });
      // Act
      final result = await fixturesRemoteDataSource.getFixtureDetails(
          fixtureDetailsUrl: testFixtureDetailsUrl);

      // Assert
      expect(result, isA<FixtureDetails>());
    });

    final errorResponse = http.Response('Not Found', 404);

    test('should throw an exception', () async {
      // Arrange
      when(mockClient.get(Uri.parse(testFixtureDetailsUrl)))
          .thenAnswer((_) async {
        return errorResponse;
      });
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (realInvocation) async {
          return [ConnectivityResult.wifi];
        },
      );
      // Act & Assert
      expect(() async {
        await fixturesRemoteDataSource.getFixtureDetails(
            fixtureDetailsUrl: testFixtureDetailsUrl);
      }, throwsA(isA<ServerException>()));
    });
    test(
      'should throw No internet exception',
      () async {
        //AAA
        //arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer(
          (realInvocation) async {
            return [ConnectivityResult.none];
          },
        );
        //act and assert
        expect(
            () async => await fixturesRemoteDataSource.getFixtureDetails(
                fixtureDetailsUrl: testFixtureDetailsUrl),
            throwsA(isA<NoInternetConnectionException>()));
      },
    );
  });
}
