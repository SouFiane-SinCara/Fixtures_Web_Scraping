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
    final String homeTeamName;
    String? homeTeamLogo;
    final String homeScore;
    final String? time;
    final String league;
    final String awayTeamName;
    String? awayTeamLogo;
    final String awayScore;
    final Element? getTime = html.querySelector(
        'a > article > div > div.SimpleMatchCard_simpleMatchCard__matchContent__prwTf > span');
    time = getTime!.innerHtml.startsWith('<time')
        ? getTime.firstChild!.text
        : getTime.innerHtml;
    league = nameLeague;
    final towTeams = html
        .querySelector(
            'a > article > div > div.SimpleMatchCard_simpleMatchCard__teamsContent__vSfWK')!
        .children;

    homeTeamName = towTeams[1]
        .querySelector(
            'span.SimpleMatchCardTeam_simpleMatchCardTeam__name__7Ud8D')!
        .innerHtml;

    homeScore = towTeams[1]
        .querySelector(
            'span.SimpleMatchCardTeam_simpleMatchCardTeam__score__UYMc_')!
        .innerHtml;
    List<Element> homeImagesSrc =
        towTeams[1].querySelector('div > div > picture')!.children.toList();

    for (int imagesSrcIndex = -1;
        homeImagesSrc.length > imagesSrcIndex;
        imagesSrcIndex++) {
      if (imagesSrcIndex == -1) {
        if (homeImagesSrc.last.attributes['src'] == null) continue;

        homeTeamLogo = homeImagesSrc.last.attributes['src'];

        break;
      }
      if (homeImagesSrc[imagesSrcIndex].attributes['srcset'] == null) {
        continue;
      }

      homeTeamLogo = homeImagesSrc[imagesSrcIndex].attributes['srcset'];
      break;
    }

    awayTeamName = towTeams[0]
        .querySelector(
            'span.SimpleMatchCardTeam_simpleMatchCardTeam__name__7Ud8D')!
        .innerHtml;
    awayScore = towTeams[0]
        .querySelector(
            'span.SimpleMatchCardTeam_simpleMatchCardTeam__score__UYMc_')!
        .innerHtml;
    List<Element> awayImagesSrc =
        towTeams[0].querySelector('div > div > picture')!.children.toList();

    for (int imagesSrcIndex = -1;
        awayImagesSrc.length > imagesSrcIndex;
        imagesSrcIndex++) {
      if (imagesSrcIndex == -1) {
        if (awayImagesSrc.last.attributes['src'] == null) continue;

        awayTeamLogo = awayImagesSrc.last.attributes['src'];

        break;
      }
      if (awayImagesSrc[imagesSrcIndex].attributes['srcset'] == null) {
        continue;
      }

      awayTeamLogo = awayImagesSrc[imagesSrcIndex].attributes['srcset'];
      break;
    }
    return FixtureModel(
        homeTeamName: homeTeamName,
        homeTeamLogo: homeTeamLogo!,
        homeScore: homeScore,
        time: time!,
        league: league,
        date: date,
        awayTeamName: awayTeamName,
        awayTeamLogo: awayTeamLogo!,
        awayScore: awayScore);
  }
}
