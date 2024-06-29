import 'package:fixtures_app/core/helpers/data_types.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';

class GetFixturesUseCase {
  final FixturesRepository fixturesRepository;

  GetFixturesUseCase({required this.fixturesRepository});

  FutureEither<List<Fixture>> call({required String date}) {
    return fixturesRepository.getFixtures(date: date);
  }
}
