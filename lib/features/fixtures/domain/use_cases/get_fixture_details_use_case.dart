import 'package:fixtures_app/core/helpers/data_types.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';

class GetFixtureDetailsUseCase {
  final FixturesRepository fixturesRepository;
  GetFixtureDetailsUseCase({
    required this.fixturesRepository,
  });

  FutureEither<FixtureDetails> call({required String fixtureDetailsUrl}) {
    throw UnimplementedError();
  }
}
