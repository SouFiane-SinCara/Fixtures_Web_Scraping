part of 'fixture_search_cubit.dart';

sealed class FixtureSearchState extends Equatable {
  const FixtureSearchState();

  @override
  List<Object> get props => [];
}

final class FixtureSearchInitial extends FixtureSearchState {}

final class UpdateFixtureSearchState extends FixtureSearchState {
  final String searchInput;

  const UpdateFixtureSearchState({required this.searchInput});  
}
