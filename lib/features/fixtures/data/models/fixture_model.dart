import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:html/dom.dart';

class FixtureModel extends Fixture {
  const FixtureModel(
      {required super.homeTeamName,
      required super.homeTeamLogo,
      required super.homeScore,
      required super.time,
      required super.league,
      required super.date,
      required super.awayTeamName,
      required super.awayTeamLogo,
      required super.awayScore});
  factory FixtureModel.fromHtml(Element html, String date, String nameLeague) {
    throw UnimplementedError();
  }
}
