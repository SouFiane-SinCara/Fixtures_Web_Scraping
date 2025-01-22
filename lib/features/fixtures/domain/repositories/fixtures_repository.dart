import 'package:dartz/dartz.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture_details.dart';

abstract class FixturesRepository {
  Future<Either<Failure, List<Fixture>>> getFixtures({required String date});
  Future<Either<Failure, FixtureDetails>> getFixtureDetails(
      {required String fixtureDetailsUrl});
}
