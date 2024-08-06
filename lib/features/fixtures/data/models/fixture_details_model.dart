import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_details.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_knockout.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/knockout_phase.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/standing.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/statistic.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team_position.dart';
import 'package:html/dom.dart';

class FixtureDetailsModel extends FixtureDetails {
  const FixtureDetailsModel(
      {required super.matchTime,
      required super.kickOff,
      required super.stadium,
      required super.leagueName,
      required super.tvGuide,
      required super.statistics,
      required super.homeTeamLastFixtures,
      required super.awayTeamLastFixtures,
      required super.standings,
      required super.knockout,
      required super.homeTeam,
      required super.homeScore,
      required super.awayTeam,
      required super.awayScore});

  String printWithDetails() {
    return '''
      matchTime: $matchTime
      kickOff: $kickOff
      stadium: $stadium
      leagueName: $leagueName
      tvGuide: $tvGuide
      statistics:  ${statistics.map(
      (e) {
        e.printWithDetails();
      },
    )}
      homeTeamLastFixtures: ${homeTeamLastFixtures.map(
      (e) => e.printDetails(),
    )}   
    
      awayTeamLastFixtures: ${awayTeamLastFixtures.map(
      (e) => e.printDetails(),
    )}
      standings: ${standings?.map(
      (e) => e.printDetails(),
    )}
      knockout: ${knockout?.map(
      (e) => e.printDetails(),
    )}
      homeTeam: ${homeTeam.printDetails()}
      homeScore: $homeScore
      awayTeam: ${awayTeam.printDetails()}
      awayScore: $awayScore
    ''';
  }

  factory FixtureDetailsModel.fromHtml(
      {required Element fixtureDetailsHtml,
      required Element? standingsHtml,
      required Element? knockoutHtml}) {
    //! ----------------------- getting fixture information---------------------------------------

    final matchTimeElement = fixtureDetailsHtml
        .getElementsByClassName('title-6-bold MatchScore_numeric__ke8YT');
    String matchTime = matchTimeElement.isEmpty
        ? fixtureDetailsHtml
                .querySelector('.MatchScore_highlightedText__hXFt7')
                ?.innerHtml ??
            'full time'
        : matchTimeElement.first.innerHtml;

    final matchInfo = fixtureDetailsHtml.getElementsByClassName(
        'title-8-regular MatchInfoEntry_subtitle__Mb7Jd');
    final teamsElements = fixtureDetailsHtml.querySelectorAll(
        'span.EntityLogo_entityLogo__29IUu.EntityLogo_entityLogoWithHover__XynBQ.MatchScoreTeam_icon__XiDSl > img');

    Team homeTeam = Team(
        name: teamsElements[0].attributes['alt']!.replaceFirst('Logo: ', ''),
        imageUrl: teamsElements[0].attributes['src']!);
    Team awayTeam = Team(
        name: teamsElements[1].attributes['alt']!.replaceFirst('Logo: ', ''),
        imageUrl: teamsElements[1].attributes['src']!);

    String leagueName = matchInfo.isEmpty ? '' : matchInfo[0].innerHtml;
    String kickOff = matchInfo.length < 2 ? '' : matchInfo[1].innerHtml;
    String stadium = matchInfo.length < 3 ? '' : matchInfo[2].innerHtml;
    String tvGuide = matchInfo.length < 4 ? '' : matchInfo[3].innerHtml;
    String homeScore = '';
    String awayScore = '';
    String score = fixtureDetailsHtml
            .getElementsByClassName(
                'MatchScore_scores__Hnn5f title-2-bold-druk')
            .isEmpty
        ? ''
        : fixtureDetailsHtml
            .getElementsByClassName(
                'MatchScore_scores__Hnn5f title-2-bold-druk')
            .first
            .text;

    String penalities = fixtureDetailsHtml.querySelector(
                '#__next > main > div > div > div.xpaLayoutContainer.XpaLayout_xpaLayoutContainerFullWidth__arqR4.xpaLayoutContainerFullWidth--matchScore > div > div > div > div > div > span') ==
            null
        ? ''
        : fixtureDetailsHtml
            .querySelector(
                '#__next > main > div > div > div.xpaLayoutContainer.XpaLayout_xpaLayoutContainerFullWidth__arqR4.xpaLayoutContainerFullWidth--matchScore > div > div > div > div > div > span')!
            .innerHtml;

    if (score != '') {
      homeScore = score[0];
      awayScore = score[score.length - 1];
    }
    if (penalities.startsWith('Pens')) {
      // Regular expression to capture the numbers
      final regex = RegExp(r'Pens:\s(\d+)\s-\s(\d+)');
      final matches = regex.firstMatch(penalities);
      final number1 = matches!.group(1);
      final number2 = matches.group(2);

      homeScore = '$homeScore ($number1)';
      awayScore = '$awayScore ($number2)';
    }

    //? ---------------------------------------getting the standings---------------------------------------
    List<Standing>? standings = standingsHtml == null ? null : [];
    if (standingsHtml != null) {
      final standingsDiv = standingsHtml
          .querySelectorAll('.xpaLayoutContainerFullWidth--standings');
      for (var tables in standingsDiv) {
        String nameStanding = tables
            .querySelector('.Standing_standings__tableHeaderText__DnwCj')!
            .innerHtml;
        final teamPositionDiv =
            tables.querySelectorAll('.Standing_standings__rowGrid__45OOd');
        List<TeamPosition> teamPositions = [];
        for (var teamPositionElement in teamPositionDiv) {
          if (teamPositionElement
                  .querySelector('.Standing_standings__teamName__psv61') ==
              null) {
            continue;
          }
          String teamName = teamPositionElement
              .querySelector('.Standing_standings__teamName__psv61')!
              .innerHtml;
          String teamLogo = teamPositionElement
              .querySelector(
                  'li > a > div.Standing_standings__team__Lzl6d > span > img')!
              .attributes['src']!;
          int gamesPlayed = int.parse(teamPositionElement
              .querySelector('li > a > div:nth-child(3)')!
              .innerHtml);
          int wins = int.parse(teamPositionElement
              .querySelector('li > a > div:nth-child(4)')!
              .innerHtml);
          int draws = int.parse(teamPositionElement
              .querySelector('li > a > div:nth-child(5)')!
              .innerHtml);
          int lose = int.parse(teamPositionElement
              .querySelector('li > a > div:nth-child(6)')!
              .innerHtml);

          int points = int.parse(teamPositionElement
              .querySelector('div:nth-child(8) > span')!
              .innerHtml);
          int goalsDifference = int.parse(teamPositionElement
              .querySelector('li > a > div:nth-child(7)')!
              .innerHtml);

          TeamPosition teamPosition = TeamPosition(
              gamesPlayed: gamesPlayed,
              lose: lose,
              wins: wins,
              draws: draws,
              points: points,
              team: Team(name: teamName, imageUrl: teamLogo),
              goalsDifference: goalsDifference);

          teamPositions.add(teamPosition);
        }
        standings!.add(
            Standing(nameStanding: nameStanding, teamPosition: teamPositions));
      }
    }
    //? ---------------------------------------getting the knockout---------------------------------------
    List<KnockoutPhase>? knockout = knockoutHtml == null ? null : [];
    if (knockoutHtml != null) {
      final treeElements =
          knockoutHtml.getElementsByClassName('KoTreeStage_list__86jBB');
      final roundNames = knockoutHtml.querySelectorAll(
          '#__next > main > div > div > div.xpaLayoutContainer.XpaLayout_xpaLayoutContainerFullWidth__arqR4.xpaLayoutContainerFullWidth--knockoutTree > div > div > ul > li > p > span');
      int roundNameIndex = 0;
      for (var treeElement in treeElements) {
        List<FixtureKnockout> fixtures = [];

        treeElement.querySelectorAll('.KoTreeNode_container__BErpF').forEach(
          (container) {
            final teams = container
                .querySelector('.KoTreeNode_teamColumn__nKJcT')!
                .children;
            Team homeTeam = Team(
                name: teams[0].attributes['alt']!,
                imageUrl: teams[0].attributes['src']!);
            Team awayTeam = Team(
                name: teams[1].attributes['alt']!,
                imageUrl: teams[1].attributes['src']!);

            FixtureKnockout fixtureKnockout = FixtureKnockout(
                score: container.text, teams: [homeTeam, awayTeam]);
            fixtures.add(fixtureKnockout);
          },
        );
        KnockoutPhase knockoutPhase = KnockoutPhase(
            roundName: roundNames[roundNameIndex].innerHtml,
            fixtures: fixtures);
        knockout!.add(knockoutPhase);
        roundNameIndex++;
      }
    }
    //? ---------------------------------------getting last matches---------------------------------------
    final lastMatches =
        fixtureDetailsHtml.querySelectorAll('.FormGuideMatch_container__6klhT');

    List<Fixture> homeTeamLastFixtures = [];
    List<Fixture> awayTeamLastFixtures = [];
    for (int i = 0; i < lastMatches.length; i++) {
      String homeTeamName;
      String homeTeamLogo;
      String date;
      String awayTeamName;
      String awayTeamLogo;
      String homeScore;
      String awayScore;
      String moreInfoLink;
      final teamLogosElement = lastMatches[i].querySelectorAll('a > div > img');
      homeTeamLogo = teamLogosElement[0].attributes['src']!;
      awayTeamLogo = teamLogosElement[1].attributes['src']!;
      homeTeamName = teamLogosElement[0].attributes['alt']!;
      awayTeamName = teamLogosElement[1].attributes['alt']!;
      homeScore = lastMatches[i]
          .querySelector(
              'a > div > p.title-7-bold.FormGuideMatch_homeScore__GNQOl')!
          .innerHtml;
      awayScore = lastMatches[i]
          .querySelector(
              'a > div > p.title-7-bold.FormGuideMatch_awayScore__JaPsF')!
          .innerHtml;
      moreInfoLink = lastMatches[i].attributes['href']!;
      date = lastMatches[i].querySelector('a > time')!.innerHtml;

      if (i < lastMatches.length / 2) {
        homeTeamLastFixtures.add(Fixture(
            homeTeamName: homeTeamName,
            homeTeamLogo: homeTeamLogo,
            homeScore: homeScore,
            leagueLogo: '',
            time: '',
            league: '',
            date: date,
            awayTeamName: awayTeamName,
            awayTeamLogo: awayTeamLogo,
            awayScore: awayScore,
            moreInfoLink: moreInfoLink));
      } else {
        awayTeamLastFixtures.add(Fixture(
            homeTeamName: homeTeamName,
            homeTeamLogo: homeTeamLogo,
            homeScore: homeScore,
            leagueLogo: '',
            time: '',
            league: '',
            date: date,
            awayTeamName: awayTeamName,
            awayTeamLogo: awayTeamLogo,
            awayScore: awayScore,
            moreInfoLink: moreInfoLink));
      }
    }
    //? ---------------------------------------getting statistics---------------------------------------
    List<Statistic> statistics = [];
    final homeStatistics = fixtureDetailsHtml
        .getElementsByClassName('MatchStatsEntry_homeValue__1MQNU');
    final awayStatistics = fixtureDetailsHtml
        .getElementsByClassName('MatchStatsEntry_awayValue__rgzMD');
    final statisticNames = fixtureDetailsHtml
        .getElementsByClassName('MatchStatsEntry_title__Vvz4Y');

    for (int i = 0; i < homeStatistics.length; i++) {
      statistics.add(Statistic(
          statisticName: statisticNames[i].text,
          homeStatistic: homeStatistics[i].text,
          awayStatistic: awayStatistics[i].text));
    }

    return FixtureDetailsModel(
        matchTime: matchTime,
        kickOff: kickOff,
        stadium: stadium,
        leagueName: leagueName,
        tvGuide: tvGuide,
        statistics: statistics,
        homeTeamLastFixtures: homeTeamLastFixtures,
        awayTeamLastFixtures: awayTeamLastFixtures,
        standings: standings,
        knockout: knockout,
        homeTeam: homeTeam,
        homeScore: homeScore,
        awayTeam: awayTeam,
        awayScore: awayScore);
  }
}
