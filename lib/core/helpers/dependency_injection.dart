import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fixtures_web_scraping/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_web_scraping/features/fixtures/data/repositories_impl/fixtures_repository_impl.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/repositories/fixtures_repository.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/use_cases/get_fixture_details_use_case.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/use_cases/get_fixtures_use_case.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/date_selection_cubit/date_selection_cubit.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixture_details_cubit/fixture_details_cubit.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixtures_cubit/fixtures_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  // Blocs
  sl.registerFactory(() => FixturesCubit(getFixturesUseCase: sl()));
  sl.registerFactory(() => FixtureDetailsCubit(getFixtureDetailsUseCase: sl()));
  sl.registerFactory(() => DateSelectionCubit());

  // Use cases
  sl.registerLazySingleton(() => GetFixturesUseCase(fixturesRepository: sl()));
  sl.registerLazySingleton(
      () => GetFixtureDetailsUseCase(fixturesRepository: sl()));

  // Repository
  sl.registerLazySingleton<FixturesRepository>(
      () => FixturesRepositoryImpl(fixturesRemoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<FixturesRemoteDataSource>(() =>
      FixturesRemoteDataSourceWebScrapping(
          httpClient: sl(), connectivity: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
