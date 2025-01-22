import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture_details.dart';

enum FixtureDetailsStatus { loading, loaded, error }

extension FixtureDetailsStateX on FixtureDetailsStatus {
  bool get isLoading => this == FixtureDetailsStatus.loading;
  bool get isLoaded => this == FixtureDetailsStatus.loaded;
  bool get isError => this == FixtureDetailsStatus.error;
}

class FixtureDetailsState {
  final FixtureDetailsStatus status;
  final FixtureDetails? fixtureDetails;
  final String error;

  const FixtureDetailsState({
    this.status = FixtureDetailsStatus.loading,
    this.fixtureDetails,
    this.error = '',
  });

  FixtureDetailsState copyWith({
    FixtureDetailsStatus? status,
    FixtureDetails? fixtureDetails,
    String? error,
  }) {
    return FixtureDetailsState(
      status: status ?? this.status,
      fixtureDetails: fixtureDetails ?? this.fixtureDetails,
      error: error ?? this.error,
    );
  }
}
