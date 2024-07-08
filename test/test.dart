import 'package:fixtures_app/features/fixtures/data/models/fixture_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';
import 'core/constants/web_src.dart';

Future<void> main() async {
  final response = await http.get(Uri.parse(fixturesUrl));
  print(response.body);
  if (response.statusCode == 200) {
    Document document = htmlParser.parse(response.body);
    final fixturesOfLeagues = document
        .querySelectorAll('.xpaLayoutContainerFullWidth--matchCardsList');
    int length = 0;
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
        FixtureModel fixture = FixtureModel.fromHtml(
            matchesDIVs[matchesDIVsIndex], '2023-5-5', nameLeague);

        length++;
      }
    }
  }
}
