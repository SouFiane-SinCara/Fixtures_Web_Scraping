import 'package:fixtures_web_scraping/core/helpers/data_types.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture_details.dart';

abstract class FixturesRepository {
  FutureEither<List<Fixture>> getFixtures({required String date});
  FutureEither<FixtureDetails> getFixtureDetails({required String fixtureDetailsUrl});
}
