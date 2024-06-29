import 'package:fixtures_app/core/constants/web_const.dart';
import 'package:fixtures_app/features/fixtures/data/models/fixture_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/core/exceptions/exceptions.dart';

abstract class FixturesRemoteDataSource {
  Future<List<Fixture>> getFixtures({required String date});
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

        final matchesDIVs = fixturesOfLeagues[fixturesOfLeaguesIndex]
            .querySelector('div > div > ul')!
            .children;
        for (int matchesDIVsIndex = 0;
            matchesDIVsIndex < matchesDIVs.length;
            matchesDIVsIndex++) {
          Fixture fixture = FixtureModel.fromHtml(
              matchesDIVs[matchesDIVsIndex], date, nameLeague);
          fixtures.add(fixture);
        }
      }
      return fixtures;
    } else {
      throw ServerException();
    }
  }
}
