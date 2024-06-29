import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';
import 'core/constants/web_src.dart';

Future<void> main() async {
  final response = await http.get(Uri.parse(fixturesUrl));

  if (response.statusCode == 200) {
    Document document = htmlParser.parse(response.body);
    final fixturesOfLeagues = document
        .querySelectorAll('.xpaLayoutContainerFullWidth--matchCardsList');

    for (int fixturesOfLeaguesIndex = 0;
        fixturesOfLeaguesIndex < fixturesOfLeagues.length;
        fixturesOfLeaguesIndex++) {
      final nameLeague = fixturesOfLeagues[fixturesOfLeaguesIndex]
          .querySelector('div > div > div > div > h2')!
          .innerHtml;

      final matchesDIVs = fixturesOfLeagues[fixturesOfLeaguesIndex]
          .querySelector('div > div > ul')!
          .children;

      for (int matchesDIVsIndex = 0;
          matchesDIVsIndex < matchesDIVs.length;
          matchesDIVsIndex++) {
        final String homeTeamName;
        String? homeTeamLogo;
        final String homeScore;
        final String? time;
        final String league;
        final String date;
        final String awayTeamName;
        String? awayTeamLogo;
        final String awayScore;
        final Element? getTime = matchesDIVs[matchesDIVsIndex].querySelector(
            'a > article > div > div.SimpleMatchCard_simpleMatchCard__matchContent__prwTf > span');
        time = getTime!.innerHtml.startsWith('<time')
            ? getTime.firstChild!.text
            : getTime.innerHtml;
        league = nameLeague;
        final towTeams = matchesDIVs[matchesDIVsIndex]
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
      }
    }
  }
}
 