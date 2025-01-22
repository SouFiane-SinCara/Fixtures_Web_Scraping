import 'package:bloc/bloc.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/use_cases/get_fixtures_use_case.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixtures_cubit/fixtures_state.dart';

class FixturesCubit extends Cubit<FixturesState> {
  final GetFixturesUseCase getFixturesUseCase;

  FixturesCubit({required this.getFixturesUseCase}) : super(FixturesState());

  void getFixtures({required String date}) {
    emit(state.copyWith(
      status: FixturesCubitStatus.loading,
    ));

    getFixturesUseCase(date: date).then((response) {
      response.fold(
        (failure) {
          emit(state.copyWith(
            status: FixturesCubitStatus.error,
            error: failure.message,
          ));
        },
        (fixtures) {
          emit(state.copyWith(
            status: FixturesCubitStatus.loaded,
            fixtures: fixtures,
          ));
        },
      );
    });
  }

  void searchFixture({required String query}) {
    emit(state.copyWith(
      status: FixturesCubitStatus.loading,
    ));

    List<Fixture> filteredFixtures = state.fixtures
        .where((fixture) =>
            fixture.homeTeamName.toLowerCase().contains(query.toLowerCase()) ||
            fixture.awayTeamName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(state.copyWith(
      status: FixturesCubitStatus.searching,
      searchingFixtures: filteredFixtures,
    ));
  }
}
