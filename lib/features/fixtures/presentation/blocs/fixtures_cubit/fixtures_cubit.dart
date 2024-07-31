import 'dart:async'; // Importing the dart:async library
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fixtures_app/core/constants/web_const.dart';
import 'package:fixtures_app/core/failures/failures.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/use_cases/get_fixtures_use_case.dart';
part 'fixtures_state.dart';

class FixturesCubit extends Cubit<FixturesState> {
  List<Fixture> fixtures = [];
  final GetFixturesUseCase getFixturesUseCase;
  Timer? _timer;

  FixturesCubit({required this.getFixturesUseCase})
      : super(FixturesLoadingState());

  Future<void> getFixtures({required String date, bool? loading}) async {
    loading == null
        ? emit(FixturesLoadingState())
        : emit(FixtureInitialState(fixtures: fixtures));
    Either<Failure, List<Fixture>> result =
        await getFixturesUseCase(date: date);
    result.fold(
      (fail) {
        emit(FixturesErrorState(errorMessage: fail.message));
      },
      (fixturesResult) {
        fixtures = fixturesResult;
        emit(FixturesLoadedState(fixtures: fixturesResult));
      },
    );
    startRecurringFixtures(date: date);
  }

  void startRecurringFixtures({required String date}) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: fixturesDelay), (timer) {
      getFixtures(date: date, loading: true);
    });
  }

  void stopRecurringFixtures() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
