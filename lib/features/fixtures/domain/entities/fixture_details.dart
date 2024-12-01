import 'package:equatable/equatable.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/knockout_phase.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/standing.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/statistic.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/team.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/entities/fixture.dart';

class FixtureDetails extends Equatable {
  final String kickOff;
  final String stadium;
  final String? tvGuide;
  final String matchTime;
  final String leagueName;
  final List<Statistic> statistics;
  final List<Fixture> homeTeamLastFixtures;
  final List<Fixture> awayTeamLastFixtures;
  final List<Standing>? standings;
  final List<KnockoutPhase>? knockout;
  final Team homeTeam;
  final String homeScore;
  final Team awayTeam;
  final String awayScore;
  const FixtureDetails({
    required this.leagueName,
    required this.matchTime,
    required this.kickOff,
    required this.stadium,
    required this.tvGuide,
    required this.statistics,
    required this.homeTeamLastFixtures,
    required this.awayTeamLastFixtures,
    required this.standings,
    required this.knockout,
    required this.homeTeam,
    required this.homeScore,
    required this.awayTeam,
    required this.awayScore,
  });

  @override
  List<Object?> get props => [
        leagueName,
        matchTime,
        kickOff,
        stadium,
        tvGuide,
        statistics,
        homeTeamLastFixtures,
        awayTeamLastFixtures,
        standings,
        knockout,
        homeTeam,
        homeScore,
        awayTeam,
        awayScore,
      ];
}
