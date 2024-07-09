import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:html/dom.dart';

class FixtureDetailsModel extends FixtureDetails {
  const FixtureDetailsModel(
      {required super.matchTime,
      required super.kickOff,
      required super.stadium,
      required super.tvGuide,
      required super.statistics,
      required super.homeTeamLastFixtures,
      required super.awayTeamLastFixtures,
      required super.standings,
      required super.knockout,
      required super.homeTeam,
      required super.homeScore,
      required super.awayTeam,
      required super.awayScore});
  factory FixtureDetailsModel.fromHtml({required Element html}) {
    throw UnimplementedError();
  }
}
