import 'package:equatable/equatable.dart';

class Fixture extends Equatable {
  final String homeTeamName;
  final String homeTeamLogo;
  final String homeScore;
  final String time;
  final String league;
  final String date;
  final String awayTeamName;
  final String awayTeamLogo;
  final String awayScore;

  const Fixture({
    required this.homeTeamName,
    required this.homeTeamLogo,
    required this.homeScore,
    required this.time,
    required this.league,
    required this.date,
    required this.awayTeamName,
    required this.awayTeamLogo,
    required this.awayScore,
  });

  @override
  List<Object> get props {
    return [
      homeTeamName,
      homeTeamLogo,
      homeScore,
      time,
      league,
      date,
      awayTeamName,
      awayTeamLogo,
      awayScore,
    ];
  }
}