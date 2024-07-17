import 'package:fixtures_app/core/exceptions/exceptions.dart';
import 'package:fixtures_app/features/fixtures/data/models/fixture_details_model.dart';
import 'package:fixtures_app/features/fixtures/data/models/fixture_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';

import 'core/constants/web_src.dart';

Future<void> main() async {
  final response =
      await http.get(Uri.parse('https://onefootball.com/en/match/2470856'));

  if (response.statusCode == 200) {
    Document fixtureDetailsDocument = htmlParser.parse(response.body);
    String theLink = fixtureDetailsDocument.body!
        .querySelector(
            '#__next > main > div > div > div.xpaLayoutContainer.XpaLayout_xpaLayoutContainerFullWidth__arqR4.xpaLayoutContainerFullWidth--matchScore > div > div > div > div > a.MatchScoreCompetition_competition__tMCd6')!
        .attributes['href']!;

    final standingsResponse =
        await http.get(Uri.parse('$targetedWebsiteUrl/$theLink/table'));
    final knockoutResponse =
        await http.get(Uri.parse('$targetedWebsiteUrl/$theLink/kotree'));

    Document standingsDocument = htmlParser.parse(standingsResponse.body);
    Document knockoutDocument = htmlParser.parse(knockoutResponse.body);

    FixtureDetailsModel fixtureDetailsModel = FixtureDetailsModel.fromHtml(
        fixtureDetailsHtml: fixtureDetailsDocument.body!,
        standingsHtml: standingsDocument.body,
        knockoutHtml: knockoutDocument.body);
  }
}
