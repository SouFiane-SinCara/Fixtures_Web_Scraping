import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/use_cases/get_fixture_details_use_case.dart';
import 'package:fixtures_web_scraping/features/fixtures/presentation/blocs/fixture_details_cubit/fixture_details_state.dart';

class FixtureDetailsCubit extends Cubit<FixtureDetailsState> {
  GetFixtureDetailsUseCase getFixtureDetailsUseCase;

  FixtureDetailsCubit({required this.getFixtureDetailsUseCase})
      : super(FixtureDetailsState());

  Future<void> getFixtureDetails({required String fixtureDetailsUrl}) async {
    emit(state.copyWith(
      status: FixtureDetailsStatus.loading,
    ));

    getFixtureDetailsUseCase(fixtureDetailsUrl: fixtureDetailsUrl)
        .then((response) {
      response.fold(
        (failure) {
          emit(state.copyWith(
            status: FixtureDetailsStatus.error,
            error: failure.message,
          ));
        },
        (fixtureDetails) {
          emit(state.copyWith(
            status: FixtureDetailsStatus.loaded,
            fixtureDetails: fixtureDetails,
          ));
        },
      );
    });
  }
}
