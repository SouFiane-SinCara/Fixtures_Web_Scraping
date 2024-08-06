part of 'fixtures_cubit.dart';

sealed class FixturesState extends Equatable {
  const FixturesState();

  @override
  List<Object> get props => [];
}

final class FixturesLoadingState extends FixturesState {}

final class FixtureUpdateState extends FixturesState {
  final List<Fixture> fixtures;
  const FixtureUpdateState({required this.fixtures});
}

final class FixturesLoadedState extends FixturesState {
  final List<Fixture> fixtures;
  const FixturesLoadedState({required this.fixtures});
}

final class FixturesErrorState extends FixturesState {
  final String errorMessage;
  const FixturesErrorState({required this.errorMessage});
}
