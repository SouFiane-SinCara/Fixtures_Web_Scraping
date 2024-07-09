// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';
import 'package:fixtures_app/core/failures/failures.dart';
import 'package:fixtures_app/core/helpers/data_types.dart';
import 'package:fixtures_app/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_app/features/fixtures/domain/repositories/fixtures_repository.dart';

class FixturesRepositoryImpl extends FixturesRepository {
  FixturesRemoteDataSource fixturesRemoteDataSource;
  FixturesRepositoryImpl({
    required this.fixturesRemoteDataSource,
  });
  @override
  FutureEither<List<Fixture>> getFixtures({required String date}) async {
    try {
      List<Fixture> fixtures =
          await fixturesRemoteDataSource.getFixtures(date: date);
      return Right(fixtures);
    } on ServerException {
      return Left(ServerFailure());
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<FixtureDetails> getFixtureDetails({required String fixtureDetailsUrl}) {
    // TODO: implement getFixtureDetails
    throw UnimplementedError();
  }
}
