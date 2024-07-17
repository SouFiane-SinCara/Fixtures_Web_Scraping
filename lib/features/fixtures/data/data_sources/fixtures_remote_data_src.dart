import 'package:fixtures_app/core/constants/web_const.dart';
import 'package:fixtures_app/features/fixtures/data/models/fixture_details_model.dart';
import 'package:fixtures_app/features/fixtures/data/models/fixture_model.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';

abstract class FixturesRemoteDataSource {
  Future<List<Fixture>> getFixtures({required String date});
  Future<FixtureDetails> getFixtureDetails({required String fixtureDetailsUrl});
}

class FixturesRemoteDataSourceWebScrapping extends FixturesRemoteDataSource {
  http.Client httpClient;
  FixturesRemoteDataSourceWebScrapping({
    required this.httpClient,
  });

  @override
  Future<List<Fixture>> getFixtures({required String date}) async {
    final response = await httpClient.get(Uri.parse(fixturesUrl));

    List<Fixture> fixtures = [];

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
        final logoLeague = fixturesOfLeagues[fixturesOfLeaguesIndex]
            .querySelector(
                'div > div > div > a > span.EntityLogo_entityLogo__29IUu.EntityLogo_entityLogoWithHover__XynBQ.SectionHeader_logo__Yjx_X > img')!
            .attributes['src'];
        final matchesDIVs = fixturesOfLeagues[fixturesOfLeaguesIndex]
            .querySelector('div > div > ul')!
            .children;
        for (int matchesDIVsIndex = 0;
            matchesDIVsIndex < matchesDIVs.length;
            matchesDIVsIndex++) {
          Fixture fixture = FixtureModel.fromHtml(
              matchesDIVs[matchesDIVsIndex], date, nameLeague, logoLeague!);
          fixtures.add(fixture);
        }
      }
      return fixtures;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<FixtureDetails> getFixtureDetails(
      {required String fixtureDetailsUrl}) async {
    final response = await httpClient
        .get(Uri.parse('https://onefootball.com/en/match/2470856'));

    if (response.statusCode == 200) {
      print(response.body);
      Document fixtureDetailsDocument = htmlParser.parse(response.body);
      String? theLink = fixtureDetailsDocument.body!
          .querySelector('.MatchScoreCompetition_competition__tMCd6')
          ?.attributes['href'];
      print('$targetedWebsiteUrl/$theLink/table');

      final standingsResponse =
          await httpClient.get(Uri.parse('$targetedWebsiteUrl/$theLink/table'));
      final knockoutResponse = await httpClient
          .get(Uri.parse('$targetedWebsiteUrl/$theLink/kotree'));
      Document standingsDocument = htmlParser.parse(standingsResponse.body);
      Document knockoutDocument = htmlParser.parse(knockoutResponse.body);

      FixtureDetailsModel fixtureDetailsModel = FixtureDetailsModel.fromHtml(
          fixtureDetailsHtml: fixtureDetailsDocument.body!,
          standingsHtml: standingsDocument.body,
          knockoutHtml: knockoutDocument.body);
      return fixtureDetailsModel;
    } else {
      throw ServerException();
    }
  }
}
