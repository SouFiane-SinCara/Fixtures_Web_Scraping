// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fixtures_app/core/helpers/data_types.dart';
import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';

class FixturesRepositoryImpl extends FixturesRepository {
  FixturesRemoteDataSource fixturesRemoteDataSource;
  FixturesRepositoryImpl({
    required this.fixturesRemoteDataSource,
  });
  @override
  FutureEither<List<Fixture>> getFixtures({String? date}) {
    throw UnimplementedError();
  }
}
