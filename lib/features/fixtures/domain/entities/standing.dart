// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:fixtures_app/features/fixtures/domain/entities/team_position.dart';

class Standing extends Equatable {
  final String nameStanding;
  final List<TeamPosition> teamPosition;
  const Standing({
    required this.nameStanding,
    required this.teamPosition,
  });
  String printDetails() {
    return '''
    nameStanding: ${nameStanding}
    teamPosition: ${teamPosition.map(
      (e) => e.printDetails(),
    )}
    ''';
  }

  @override
  List<Object?> get props => [nameStanding, teamPosition];
}
