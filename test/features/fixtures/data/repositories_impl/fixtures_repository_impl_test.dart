import 'package:dartz/dartz.dart';
import 'package:fixtures_app/core/failures/failures.dart';
import 'package:fixtures_app/core/helpers/data_types.dart';
import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/data/repositories_impl/fixtures_repository_impl.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';

import '../../../../core/constants/expected_fixture_details_model.dart';
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
    'get fixtures repository',
    () {
      List<Fixture> fixturesTest = const [
        Fixture(
            homeTeamName: "Manchester United",
            homeTeamLogo: "man_utd_logo.png",
            moreInfoLink: '/en/match/2509332',
            homeScore: '2',
            time: "90'",
            leagueLogo: '',
            league: "Premier League",
            date: "2024-06-26",
            awayTeamName: "Liverpool",
            awayTeamLogo: "liverpool_logo.png",
            awayScore: '1'),
        Fixture(
            homeTeamName: "Real Madrid",
            homeTeamLogo: "real_madrid_logo.png",
            leagueLogo: '',
            homeScore: '3',
            moreInfoLink: '/en/match/2515122',
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
  group(
    'get fixture details',
    () {
      const String testFixtureDetailsUrl =
          'https://onefootball.com/en/match/2470856';

      test(
        'should return fixture details',
        () async {
          const successResponse = Right(expectedFixtureDetailsModel);
          //AAA
          //arrange
          when(mockFixturesRemoteDataSource.getFixtureDetails(
                  fixtureDetailsUrl: testFixtureDetailsUrl))
              .thenAnswer(
            (_) async {
              return expectedFixtureDetailsModel;
            },
          );
          //act
          final result = await fixturesRepository.getFixtureDetails(
              fixtureDetailsUrl: testFixtureDetailsUrl);
          //assert
          expect(result, equals(successResponse));
        },
      );
      Either<Failure, FixtureDetails> noInternetConnectionFailure =
          Left(NoInternetConnectionFailure());
      test(
        'should return no internet failure',
        () async {
          //AAA
          //arrange
          when(mockFixturesRemoteDataSource.getFixtureDetails(
                  fixtureDetailsUrl: testFixtureDetailsUrl))
              .thenAnswer(
            (_) async {
              throw NoInternetConnectionException();
            },
          );
          //act

          final result = await fixturesRepository.getFixtureDetails(
              fixtureDetailsUrl: testFixtureDetailsUrl);
          //assert
          expect(result, isA<Left>());
        },
      );
      Either<Failure, FixtureDetails> serverFailure = Left(ServerFailure());
      test(
        'should return Server failure',
        () async {
          //AAA
          //arrange
          when(mockFixturesRemoteDataSource.getFixtureDetails(
                  fixtureDetailsUrl: testFixtureDetailsUrl))
              .thenAnswer(
            (_) async {
              throw ServerException();
            },
          );
          //act

          final result = await fixturesRepository.getFixtureDetails(
              fixtureDetailsUrl: testFixtureDetailsUrl);
          //assert
          expect(result, isA<Left>());  
        },
      );
    },
  );
}