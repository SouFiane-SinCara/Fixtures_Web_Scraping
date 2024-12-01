import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fixtures_web_scraping/core/exceptions/exceptions.dart';
import 'package:fixtures_web_scraping/features/fixtures/data/models/fixture_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

import 'core/constants/web_src.dart';

Future<void> main() async {
  final internetConnectionResult = await Connectivity().checkConnectivity();
  if (internetConnectionResult.first == ConnectivityResult.none) {
    throw NoInternetConnectionException();
  } else {
    final response =
        await http.get(Uri.parse('https://onefootball.com/en/match/2470856'));

    if (response.statusCode == 200) {
      Document fixtureDetailsDocument = html_parser.parse(response.body);
      String theLink = fixtureDetailsDocument.body!
          .querySelector(
              '#__next > main > div > div > div.xpaLayoutContainer.XpaLayout_xpaLayoutContainerFullWidth__arqR4.xpaLayoutContainerFullWidth--matchScore > div > div > div > div > a.MatchScoreCompetition_competition__tMCd6')!
          .attributes['href']!;

      final standingsResponse =
          await http.get(Uri.parse('$targetedWebsiteUrl/$theLink/table'));
      final knockoutResponse =
          await http.get(Uri.parse('$targetedWebsiteUrl/$theLink/kotree'));

      Document standingsDocument = html_parser.parse(standingsResponse.body);
      Document knockoutDocument = html_parser.parse(knockoutResponse.body);

      FixtureDetailsModel.fromHtml(
          fixtureDetailsHtml: fixtureDetailsDocument.body!,
          standingsHtml: standingsDocument.body,
          knockoutHtml: knockoutDocument.body);
    } else {
      throw ServerException();
    }
  }
}
