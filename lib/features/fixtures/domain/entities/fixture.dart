import 'package:equatable/equatable.dart';

class Fixture extends Equatable {
  final String homeTeamName;
  final String homeTeamLogo;
  final String homeScore;
  final String time;
  final String league;
  final String leagueLogo;
  final String date;
  final String awayTeamName;
  final String awayTeamLogo;
  final String awayScore;
  final String moreInfoLink;
  const Fixture(
      {required this.homeTeamName,
      required this.homeTeamLogo,
      required this.homeScore,
      required this.leagueLogo,
      required this.time,
      required this.league,
      required this.date,
      required this.awayTeamName,
      required this.awayTeamLogo,
      required this.awayScore,
      required this.moreInfoLink});
  String printDetails() {
    return '''
      homeTeamName: $homeTeamName
      homeTeamLogo: $homeTeamLogo
      homeScore: $homeScore
      time: $time
      league: $league
      leagueLogo: $leagueLogo
      date: $date
      awayTeamName: $awayTeamName
      awayTeamLogo: $awayTeamLogo
      awayScore: $awayScore
      moreInfoLink: $moreInfoLink
    ''';
  }

  @override
  List<Object> get props {
    return [
      homeTeamName,
      homeTeamLogo,
      homeScore,
      time,
      leagueLogo,
      league,
      moreInfoLink,
      date,
      awayTeamName,
      awayTeamLogo,
      awayScore,
    ];
  }
}
