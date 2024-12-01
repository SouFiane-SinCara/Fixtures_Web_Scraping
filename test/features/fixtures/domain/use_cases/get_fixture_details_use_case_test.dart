import 'package:dartz/dartz.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/team.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/repositories/fixtures_repository.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/use_cases/get_fixture_details_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late FixturesRepository mockFixturesRepository;
  late GetFixtureDetailsUseCase getFixtureDetailsUseCase;
  setUp(
    () {
      mockFixturesRepository = MockFixturesRepository();
      getFixtureDetailsUseCase =
          GetFixtureDetailsUseCase(fixturesRepository: mockFixturesRepository);
    },
  );
  group(
    'get fixture details use case',
    () {
      String testFixtureDetailsUrl = '/12151058';
      FixtureDetails testFixtureDetails = const FixtureDetails(
          matchTime: '20:00',
          leagueName: 'league',
          kickOff: 'today',
          stadium: 'stadium',
          tvGuide: 'tvGuide',
          statistics: [],
          homeTeamLastFixtures: [
            Fixture(
                homeTeamName: 'homeTeamName',
                homeTeamLogo: 'homeTeamLogo',
                homeScore: 'homeScore',
                time: 'time',
                league: 'league',
                date: 'date',
                awayTeamName: 'awayTeamName',
                leagueLogo: '',
                awayTeamLogo: 'awayTeamLogo',
                awayScore: 'awayScore',
                moreInfoLink: 'moreInfoLink')
          ],
          awayTeamLastFixtures: [
            Fixture(
                homeTeamName: 'homeTeamName',
                homeTeamLogo: 'homeTeamLogo',
                homeScore: 'homeScore',
                time: 'time',
                league: 'league',
                leagueLogo: '',
                date: 'date',
                awayTeamName: 'awayTeamName',
                awayTeamLogo: 'awayTeamLogo',
                awayScore: 'awayScore',
                moreInfoLink: 'moreInfoLink')
          ],
          standings: null,
          knockout: null,
          homeTeam: Team(name: 'name', imageUrl: 'imageUrl'),
          homeScore: 'homeScore',
          awayTeam: Team(name: 'name', imageUrl: 'imageUrl'),
          awayScore: 'awayScore');

      test('should return Right fixture details', () async {
        //AAA
        //arrange
        when(mockFixturesRepository.getFixtureDetails(
                fixtureDetailsUrl: testFixtureDetailsUrl))
            .thenAnswer(
          (realInvocation) async {
            return Right(testFixtureDetails);
          },
        );
        //act
        final result = await getFixtureDetailsUseCase(
            fixtureDetailsUrl: testFixtureDetailsUrl);
        //assert
        expect(result, equals(Right(testFixtureDetails)));
      });
      Either<Failure, FixtureDetails> testFailure = Left(ServerFailure());
      test('should return left failure', () async {
        //AAA
        //arrange
        when(mockFixturesRepository.getFixtureDetails(
                fixtureDetailsUrl: testFixtureDetailsUrl))
            .thenAnswer(
          (realInvocation) async {
            return testFailure;
          },
        );
        //act
        final result = await getFixtureDetailsUseCase(
            fixtureDetailsUrl: testFixtureDetailsUrl);
        //assert
        expect(result, equals(testFailure));
      });
    },
  );
}
