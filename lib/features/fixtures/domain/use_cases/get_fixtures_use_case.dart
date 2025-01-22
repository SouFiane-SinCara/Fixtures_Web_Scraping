import 'package:dartz/dartz.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/repositories/fixtures_repository.dart';

class GetFixturesUseCase {
  final FixturesRepository fixturesRepository;

  GetFixturesUseCase({required this.fixturesRepository});

  Future<Either<Failure, List<Fixture>>> call({required String date}) {
    return fixturesRepository.getFixtures(date: date);
  }
}
