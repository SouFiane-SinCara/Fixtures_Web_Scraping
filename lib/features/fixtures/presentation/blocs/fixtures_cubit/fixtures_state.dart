import 'package:equatable/equatable.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';

enum FixturesCubitStatus { initial, loading, loaded, error, searching }

extension StatusX on FixturesCubitStatus {
  bool get isInitial => this == FixturesCubitStatus.initial;
  bool get isLoading => this == FixturesCubitStatus.loading;
  bool get isLoaded => this == FixturesCubitStatus.loaded;
  bool get isError => this == FixturesCubitStatus.error;
  bool get isSearching => this == FixturesCubitStatus.searching;
}

class FixturesState extends Equatable {
  final FixturesCubitStatus status;
  final List<Fixture> fixtures;
  final List<Fixture> searchingFixtures;
  final String error;

  const FixturesState({
    this.status = FixturesCubitStatus.loading,
    this.fixtures = const <Fixture>[],
    this.searchingFixtures = const <Fixture>[],
    this.error = '',
  });

  FixturesState copyWith({
    FixturesCubitStatus? status,
    List<Fixture>? fixtures,
    List<Fixture>? searchingFixtures,
    String? error,
  }) {
    return FixturesState(
      status: status ?? this.status,
      fixtures: fixtures ?? this.fixtures,
      searchingFixtures: searchingFixtures ?? this.searchingFixtures,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, fixtures, error];
}
