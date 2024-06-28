import 'package:fixtures_app/core/helpers/data_types.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';

abstract class FixturesRepository {
  FutureEither<List<Fixture>> getFixtures({String? date});
}
