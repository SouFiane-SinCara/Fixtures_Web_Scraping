import 'dart:io';

import 'package:fixtures_app/features/fixtures/data/models/fixture_details_model.dart';
import 'package:fixtures_app/features/fixtures/data/models/fixture_model.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

void main() {
  group(
    'fixture details model',
    () {
      String testDate = '2023';
      FixtureDetails testFixtureDetails = const FixtureDetails(
          matchTime: '20:00',
          kickOff: 'today',
          stadium: 'stadium',
          tvGuide: 'tvGuide',
          statistics: {},
          homeTeamLastFixtures: [
            Fixture(
                homeTeamName: 'homeTeamName',
                homeTeamLogo: 'homeTeamLogo',
                homeScore: 'homeScore',
                time: 'time',
                league: 'league',
                date: 'date',
                awayTeamName: 'awayTeamName',
                awayTeamLogo: 'awayTeamLogo',
                awayScore: 'awayScore',
                moreInfoLink: 'moreInfoLink')
          ],
          awayTeamLastFixtures: [
            Fixture(
                homeTeamName: 'homeTeamName',
                homeTeamLogo: 'homeTeamLogo',
                homeScore: 'homeScore',
                time: 'time',
                league: 'league',
                date: 'date',
                awayTeamName: 'awayTeamName',
                awayTeamLogo: 'awayTeamLogo',
                awayScore: 'awayScore',
                moreInfoLink: 'moreInfoLink')
          ],
          standings: null,
          knockout: null,
          homeTeam: Team(name: 'name', imageUrl: 'imageUrl'),
          homeScore: 'homeScore',
          awayTeam: Team(name: 'name', imageUrl: 'imageUrl'),
          awayScore: 'awayScore');
      test(
        'should return Fixture details model from html element',
        () async {
          //AAA
          //arrange
          final String response =
              await File('test/core/constants/fixture_details.html')
                  .readAsString();
          Element html = Element.html(response);
          //act
          final result = FixtureDetailsModel.fromHtml(html: html);
          //assert
          expect(result, isA<FixtureDetailsModel>());
        },
      );
    },
  );
}
