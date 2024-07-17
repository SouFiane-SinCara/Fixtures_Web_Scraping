import 'dart:io';

import 'package:fixtures_app/features/fixtures/data/models/fixture_details_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as htmlParser;
import '../../../../core/constants/expected_fixture_details_model.dart';

void main() {
  group(
    'fixture details model',
    () {
      test(
        'should return Fixture details model from html element',
        () async {
          //AAA
          //arrange
          final String fixtureDetailsResponse =
              await File('test/core/constants/fixture_details_response.html')
                  .readAsString();
          final String standingsResponse =
              await File('test/core/constants/standings_response.html')
                  .readAsString();
          final String knockoutResponse =
              await File('test/core/constants/knockout_response.html')
                  .readAsString();

          Document fixtureDetailsDocument =
              htmlParser.parse(fixtureDetailsResponse);
          Document standingsDocument = htmlParser.parse(standingsResponse);
          Document knockoutDocument = htmlParser.parse(knockoutResponse);
          //act
          final result = FixtureDetailsModel.fromHtml(
              fixtureDetailsHtml: fixtureDetailsDocument.body!,
              standingsHtml: standingsDocument.body,
              knockoutHtml: knockoutDocument.body);

          //assert
          expect(result, equals(expectedFixtureDetailsModel));
        },
      );
    },
  );
} 