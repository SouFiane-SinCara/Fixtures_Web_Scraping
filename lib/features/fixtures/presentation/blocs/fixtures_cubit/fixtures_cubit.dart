import 'dart:async'; // Importing the dart:async library
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fixtures_web_scraping/core/constants/web_const.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/use_cases/get_fixtures_use_case.dart';
part 'fixtures_state.dart';

class FixturesCubit extends Cubit<FixturesState> {
  List<Fixture> fixtures = [];
  bool stillUpdating = true;
  final GetFixturesUseCase getFixturesUseCase;
  Timer? _timer;

  FixturesCubit({required this.getFixturesUseCase})
      : super(FixturesLoadingState());

  Future<void> getFixtures({required String date, bool? updating}) async {
    print('getting fixtures');
    updating == null
        ? emit(FixturesLoadingState())
        : emit(FixtureUpdateState(fixtures: fixtures));
    updating == null ? stillUpdating = true : null;
    if (!stillUpdating) {
      _timer?.cancel();
      return;
    }
    Either<Failure, List<Fixture>> result =
        await getFixturesUseCase(date: date);
    result.fold(
      (fail) {
        emit(FixturesErrorState(errorMessage: fail.message));
      },
      (fixturesResult) {
        fixtures = fixturesResult;

        if (fixtures.isEmpty) {
          emit(const FixturesErrorState(errorMessage: 'no fixtures today'));
        } else {
          emit(FixturesLoadedState(fixtures: fixturesResult));
        }
      },
    );

    startRecurringFixtures(date: date);
  }

  void stopUpdating() {
    stillUpdating = false;
  }

  void startRecurringFixtures({required String date}) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: fixturesDelay), (timer) {
      getFixtures(date: date, updating: true);
    });
  }
}
