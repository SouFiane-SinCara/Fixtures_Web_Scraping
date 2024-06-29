import 'package:dartz/dartz.dart';
import 'package:fixtures_app/core/failures/failures.dart';
import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/data/repositories_impl/fixtures_repository_impl.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late FixturesRepository fixturesRepository;
  late FixturesRemoteDataSource mockFixturesRemoteDataSource;
  setUp(
    () {
      mockFixturesRemoteDataSource = MockFixturesRemoteDataSource();
      fixturesRepository = FixturesRepositoryImpl(
          fixturesRemoteDataSource: mockFixturesRemoteDataSource);
    },
  );
  group(
    'fixtures repository',
    () {
      List<Fixture> fixturesTest = const [
        Fixture(
            homeTeamName: "Manchester United",
            homeTeamLogo: "man_utd_logo.png",
            homeScore: '2',
            time: "90'",
            league: "Premier League",
            date: "2024-06-26",
            awayTeamName: "Liverpool",
            awayTeamLogo: "liverpool_logo.png",
            awayScore: '1'),
        Fixture(
            homeTeamName: "Real Madrid",
            homeTeamLogo: "real_madrid_logo.png",
            homeScore: '3',
            time: "FT",
            league: "La Liga",
            date: "2024-06-27",
            awayTeamName: "Barcelona",
            awayTeamLogo: "barcelona_logo.png",
            awayScore: '2')
      ];
      final expectedSuccess = Right(fixturesTest);
      String testDate = '2024-06-28';
      test(
        'should return right List of fixture',
        () async {
          //AAA
          //arrange
          when(mockFixturesRemoteDataSource.getFixtures(date: testDate))
              .thenAnswer(
            (_) async {
              return fixturesTest;
            },
          );
          //act
          final result = await fixturesRepository.getFixtures(date: testDate);
          //assert
          expect(result, equals(expectedSuccess));
        },
      );
      test(
        'should return left failure',
        () async {
          //AAA
          //arrange
          when(mockFixturesRemoteDataSource.getFixtures(date: testDate))
              .thenAnswer(
            (_) async {
              throw ServerException();
            },
          );
          //act
          final result = await fixturesRepository.getFixtures(date: testDate);
          //assert
          expect(result, isA<Left>());
        },
      );
    },
  );
}
