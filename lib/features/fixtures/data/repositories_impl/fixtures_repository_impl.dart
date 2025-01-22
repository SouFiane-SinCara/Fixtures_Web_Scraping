// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:fixtures_web_scraping/core/exceptions/exceptions.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart';
import 'package:fixtures_web_scraping/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/repositories/fixtures_repository.dart';

class FixturesRepositoryImpl extends FixturesRepository {
  FixturesRemoteDataSource fixturesRemoteDataSource;
  FixturesRepositoryImpl({
    required this.fixturesRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<Fixture>>> getFixtures(
      {required String date}) async {
    try {
      List<Fixture> fixtures =
          await fixturesRemoteDataSource.getFixtures(date: date);
      return Right(fixtures);
    } on NoInternetConnectionException {
      return Left(NoInternetConnectionFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(GeneraleFailure());
    }
  }

  @override
  Future<Either<Failure, FixtureDetails>> getFixtureDetails(
      {required String fixtureDetailsUrl}) async {
    try {
      FixtureDetails fixtureDetails = await fixturesRemoteDataSource
          .getFixtureDetails(fixtureDetailsUrl: fixtureDetailsUrl);
      return Right(fixtureDetails);
    } on NoInternetConnectionException {
      return Left(NoInternetConnectionFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(GeneraleFailure());
    }
  }
}
