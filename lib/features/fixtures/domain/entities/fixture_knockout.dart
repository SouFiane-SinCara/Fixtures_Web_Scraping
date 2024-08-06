import 'package:equatable/equatable.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team.dart';

class FixtureKnockout extends Equatable {
  final String score;
  final List<Team> teams;
  const FixtureKnockout({
    required this.score,
    required this.teams,
  });
  String printDetails() {
    return '''
    status: $score
    teams: ${teams.map(
      (e) => e.printDetails(),
    )}
    ''';
  }

  @override
  List<Object?> get props => [teams, score];
}
