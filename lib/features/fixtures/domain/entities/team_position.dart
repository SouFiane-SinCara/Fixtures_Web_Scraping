// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/team.dart';

class TeamPosition extends Equatable {
  final int gamesPlayed;
  final int wins;
  final int draws;
  final int lose;
  final int points;
  final int goalsDifference;
  final Team team;

  const TeamPosition({
    required this.gamesPlayed,
    required this.wins,
    required this.draws,
    required this.lose,
    required this.points,
    required this.team,
    required this.goalsDifference,
  });
  String printDetails(){
    return
    '''
    gamesPlayed : $gamesPlayed
    wins : $wins
    draws : $draws
    lose : $lose
    points : $points
    team : name: ${team.name} imageUrl: ${team.imageUrl}
    goalsDifference : $goalsDifference

    ''';
  }
  @override
  List<Object?> get props =>
      [gamesPlayed, wins, lose, draws, points, goalsDifference, team];
}
