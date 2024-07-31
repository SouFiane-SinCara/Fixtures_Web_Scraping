import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:html/dom.dart';

class FixtureModel extends Fixture {
  const FixtureModel({
    required super.homeTeamName,
    required super.homeTeamLogo,
    required super.homeScore,
    required super.time,
    required super.leagueLogo,
    required super.league,
    required super.date,
    required super.awayTeamName,
    required super.awayTeamLogo,
    required super.awayScore,
    required super.moreInfoLink,
  });
  factory FixtureModel.fromHtml(
      Element html, String date, String nameLeague, String logoLeague) {
    final String homeTeamName;
    String? homeTeamLogo;
    final String homeScore;
    String? time;
    final String league;
    final String awayTeamName;
    final String moreInfoLink;
    String? awayTeamLogo;
    final String awayScore;
    String determineMatchTime(Element html) {
      Element? normalTime = html.querySelector(
          '.SimpleMatchCard_simpleMatchCard__infoMessage___NJqW');
      if (normalTime != null) {
        return normalTime.text;
      }

      Element? playingTime =
          html.querySelector('.SimpleMatchCard_simpleMatchCard__live__kg0bW');
      if (playingTime != null) {
        return playingTime.text;
      }

      Element? warningMessage = html.querySelector(
          '.SimpleMatchCard_simpleMatchCard__warningMessage__7lDK2');
      if (warningMessage != null) {
        return warningMessage.text;
      }

      return 'Full time';
    }

    time = determineMatchTime(html);
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
    String suffixMoreInfoLink = html.querySelector('a')!.attributes['href']!;
    moreInfoLink = 'https://onefootball.com$suffixMoreInfoLink';
    return FixtureModel(
        homeTeamName: homeTeamName,
        homeTeamLogo: homeTeamLogo!,
        homeScore: homeScore,
        time: time,
        league: league,
        leagueLogo: logoLeague,
        moreInfoLink: moreInfoLink,
        date: date,
        awayTeamName: awayTeamName,
        awayTeamLogo: awayTeamLogo!,
        awayScore: awayScore);
  }
}
