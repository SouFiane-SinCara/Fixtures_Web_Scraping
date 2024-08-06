import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fixtures_app/core/constants/web_const.dart';
import 'package:fixtures_app/core/failures/failures.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_app/features/fixtures/domain/use_cases/get_fixture_details_use_case.dart';

part 'fixture_details_state.dart';

class FixtureDetailsCubit extends Cubit<FixtureDetailsState> {
  GetFixtureDetailsUseCase getFixtureDetailsUseCase;
  FixtureDetails? fixtureDetails;
  Timer? _timer;
  bool stillUpdating = true;
  FixtureDetailsCubit({required this.getFixtureDetailsUseCase})
      : super(FixtureDetailsLoading());

  Future<void> getFixtureDetails(
      {required String fixtureDetailsUrl, bool? updating}) async {
    updating == null
        ? emit(FixtureDetailsLoading())
        : emit(UpdateFixtureDetailsState(fixtureDetails: fixtureDetails!));
    updating == null ? stillUpdating = true : null;
    if (!stillUpdating) {
      _timer!.cancel();
      return;
    }
    Either<Failure, FixtureDetails> result =
        await getFixtureDetailsUseCase(fixtureDetailsUrl: fixtureDetailsUrl);
    result.fold(
      (fail) {
        emit(ErrorFixtureDetailsState(message: fail.message));
      },
      (fixtureDetails) {
        this.fixtureDetails = fixtureDetails;
        emit(LoadedFixtureDetailsState(fixtureDetails: fixtureDetails));
      },
    );

    startRecurringFixtureDetails(fixtureDetailsUrl: fixtureDetailsUrl);
  }

  void stopUpdating() {
    stillUpdating = false;
  }

  void startRecurringFixtureDetails({required String fixtureDetailsUrl}) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: fixturesDelay), (timer) {
      getFixtureDetails(fixtureDetailsUrl: fixtureDetailsUrl, updating: true);
    });
  }

  void stopRecurringFixtureDetails() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
