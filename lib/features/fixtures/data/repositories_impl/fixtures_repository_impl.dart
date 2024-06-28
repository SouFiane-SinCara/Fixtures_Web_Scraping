import 'package:fixtures_app/core/helpers/data_types.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';

class FixturesRepositoryImpl extends FixturesRepository {
  @override
  FutureEither<List<Fixture>> getFixtures({String? date}) {
    throw UnimplementedError();
  }
}
