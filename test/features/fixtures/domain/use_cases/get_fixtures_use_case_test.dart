import 'package:dartz/dartz.dart';
import 'package:fixtures_app/core/failures/failures.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';
import 'package:fixtures_app/features/fixtures/domain/use_cases/get_fixtures_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/helpers/test_helper.mocks.dart';

void main() {
  late GetFixturesUseCase getFixturesUseCase;
  late FixturesRepository mockFixturesRepository;
  group('get fixtures', () {
    setUp(() {
      mockFixturesRepository = MockFixturesRepository();
      getFixturesUseCase =
          GetFixturesUseCase(fixturesRepository: mockFixturesRepository);
    });

    List<Fixture> fixturesTest = const [
      Fixture(
          homeTeamName: "Manchester United",
          homeTeamLogo: "man_utd_logo.png",
          homeScore: '2',
          moreInfoLink: '/en/match/2515122',
          time: "90'",
          league: "Premier League",
          date: "2024-06-26",
          awayTeamName: "Liverpool",
          awayTeamLogo: "liverpool_logo.png",
          awayScore: '1'),
      Fixture(
          homeTeamName: "Real Madrid",
          homeTeamLogo: "real_madrid_logo.png",
          moreInfoLink: '/en/match/2509332',
          homeScore: '3',
          time: "FT",
          league: "La Liga",
          date: "2024-06-27",
          awayTeamName: "Barcelona",
          awayTeamLogo: "barcelona_logo.png",
          awayScore: '2')
    ];
    String testDate = '2024-06-25';
    test("should get fixtures from the repository ", () async {
      //AAA
      //arrange
      when(mockFixturesRepository.getFixtures(date: testDate))
          .thenAnswer((realInvocation) async => Right(fixturesTest));
      //act
      final result = await getFixturesUseCase(date: testDate);
      //assert
      expect(result, equals(Right(fixturesTest)));
    });
    final failure = ServerFailure();
    test("should return a failure", () async {
      //AAA
      //arrange
      when(mockFixturesRepository.getFixtures(date: testDate))
          .thenAnswer((realInvocation) async => Left(failure));
      //act
      final result = await getFixturesUseCase(date: testDate);
      //assert
      expect(result, equals(Left(failure)));
    });
  });
}
