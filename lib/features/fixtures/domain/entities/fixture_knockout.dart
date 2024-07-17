import 'package:equatable/equatable.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team.dart';

class FixtureKnockout extends Equatable {
  final String status;
  final List<Team> teams;
  const FixtureKnockout({
    required this.status,
    required this.teams,
  });
  String printDetails() {
    return '''
    status: $status
    teams: ${teams.map(
      (e) => e.printDetails(),
    )}
    ''';
  }

  @override
  List<Object?> get props => [teams, status];
}
