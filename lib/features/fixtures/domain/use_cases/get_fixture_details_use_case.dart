import 'package:dartz/dartz.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart'; 
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/repositories/fixtures_repository.dart';

class GetFixtureDetailsUseCase {
  final FixturesRepository fixturesRepository;
  GetFixtureDetailsUseCase({
    required this.fixturesRepository,
  });

 Future<Either<Failure, FixtureDetails>>  call({required String fixtureDetailsUrl}) {
    return fixturesRepository.getFixtureDetails(
        fixtureDetailsUrl: fixtureDetailsUrl);
  }
}
