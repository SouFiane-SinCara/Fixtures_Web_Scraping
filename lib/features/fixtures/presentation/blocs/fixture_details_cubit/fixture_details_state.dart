part of 'fixture_details_cubit.dart';

sealed class FixtureDetailsState extends Equatable {
  const FixtureDetailsState();

  @override
  List<Object> get props => [];
}

final class FixtureDetailsLoading extends FixtureDetailsState {}

final class UpdateFixtureDetailsState extends FixtureDetailsState {
  final FixtureDetails fixtureDetails;

  const UpdateFixtureDetailsState({required this.fixtureDetails});
}

final class ErrorFixtureDetailsState extends FixtureDetailsState {
  final String message;

  const ErrorFixtureDetailsState({required this.message});
}

final class LoadedFixtureDetailsState extends FixtureDetailsState {
  final FixtureDetails fixtureDetails;

  const LoadedFixtureDetailsState({required this.fixtureDetails});
}
