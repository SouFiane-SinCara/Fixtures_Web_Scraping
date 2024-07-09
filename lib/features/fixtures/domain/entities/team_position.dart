// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team.dart';

class TeamPosition extends Equatable {
  final int gamesPlayed;
  final int wins;
  final int draws;
  final int points;
  final int goalsDifference;
  final Team team;
  const TeamPosition({
    required this.gamesPlayed,
    required this.wins,
    required this.draws,
    required this.points,
    required this.team,
    required this.goalsDifference,
  });
  @override
  List<Object?> get props =>
      [gamesPlayed, wins, draws, points, goalsDifference, team];
}
