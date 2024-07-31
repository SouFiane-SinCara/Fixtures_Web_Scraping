import 'dart:io';

import 'package:fixtures_app/features/fixtures/data/models/fixture_details_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
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
              html_parser.parse(fixtureDetailsResponse);
          Document standingsDocument = html_parser.parse(standingsResponse);
          Document knockoutDocument = html_parser.parse(knockoutResponse);
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