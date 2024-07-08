import 'dart:io';

import 'package:fixtures_app/features/fixtures/data/models/fixture_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';

void main() {
  group(
    'fixture model',
    () {
      String testDate = '2024-06-28';
      String testLeague = 'Copa América';
      FixtureModel testFixture = const FixtureModel(
          homeTeamName: 'USA',
          homeTeamLogo:
              'https://image-service.onefootball.com/transform?w=22&h=22&dpr=2&image=https%253A%252F%252Fimages.onefootball.com%252Ficons%252Fteams%252F164%252F81.png',
          homeScore: '1',
          time: 'Full time',
          league: 'Copa América',
          date: '2024-06-28',
          awayTeamName: 'Panama',
          moreInfoLink: '/en/match/2470839',
          awayTeamLogo:
              'https://image-service.onefootball.com/transform?w=22&h=22&dpr=2&image=https%253A%252F%252Fimages.onefootball.com%252Ficons%252Fteams%252F164%252F1022.png',
          awayScore: '2');
      test(
        'should return a fixture',
        () {
          //AAA
          //arrange
          String response =
              File('test/core/constants/fixture_data.html').readAsStringSync();
          Element testFixtureHtml = Element.html(response);
          //act 
          FixtureModel result =
              FixtureModel.fromHtml(testFixtureHtml, testDate, testLeague);
          print("result"+result.moreInfoLink);
          //assert
          expect(result, equals(testFixture));
        },
      );
    },
  );
}
