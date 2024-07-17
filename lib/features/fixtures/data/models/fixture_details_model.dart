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
      matchTime: ${matchTime}
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
        ? 'full time'
        : matchTimeElement.first.innerHtml;

    final matchInfo = fixtureDetailsHtml.getElementsByClassName(
        'title-8-regular MatchInfoEntry_subtitle__Mb7Jd');
    final teamsElements = fixtureDetailsHtml.querySelectorAll(
        'span.EntityLogo_entityLogo__29IUu.EntityLogo_entityLogoWithHover__XynBQ.MatchScoreTeam_icon__XiDSl > img');

    Team homeTeam = Team(
        name: teamsElements[0].attributes['alt']!,
        imageUrl: teamsElements[0].attributes['src']!);
    Team awayTeam = Team(
        name: teamsElements[1].attributes['alt']!,
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
    if (penalities.startsWith('pens') && penalities != '') {
      // Regular expression to capture the numbers
      final regex = RegExp(r'Pens:\s(\d+)\s-\s(\d+)');
      final matches = regex.firstMatch(penalities);
      final number1 = matches!.group(1);
      final number2 = matches.group(2);
      homeScore = '$homeScore($number1)';
      awayScore = '$awayScore($number2)';
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
      treeElements.forEach(
        (treeElement) {
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
                  status: container.text, teams: [homeTeam, awayTeam]);
              fixtures.add(fixtureKnockout);
            },
          );
          KnockoutPhase knockoutPhase = KnockoutPhase(
              roundName: roundNames[roundNameIndex].innerHtml,
              fixtures: fixtures);
          knockout!.add(knockoutPhase);
          roundNameIndex++;
        },
      );
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

      if (i < 5) {
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
/*
      matchTime: full time
      kickOff: 14/07/2024
      stadium: Bank of America Stadium
      leagueName: Copa América
      tvGuide: Mola TV (Italy)
      statistics:  (null, null, null, null)
      homeTeamLastFixtures: (      homeTeamName: Canada
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png
      homeScore: 2
      time: 
      league: 
      leagueLogo: 
      date: 14/07
      awayTeamName: Uruguay
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png
      awayScore: 2
      moreInfoLink: https://onefootball.com/en/match/2470856
    ,       homeTeamName: Argentina
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/55.png
      homeScore: 2
      time: 
      league: 
      leagueLogo: 
      date: 10/07
      awayTeamName: Canada
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png
      awayScore: 0
      moreInfoLink: https://onefootball.com/en/match/2470854
    ,       homeTeamName: Venezuela
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/591.png
      homeScore: 1
      time: 
      league: 
      leagueLogo: 
      date: 06/07
      awayTeamName: Canada
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png
      awayScore: 1
      moreInfoLink: https://onefootball.com/en/match/2470851
    ,       homeTeamName: Canada
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png
      homeScore: 0
      time: 
      league: 
      leagueLogo: 
      date: 30/06
      awayTeamName: Chile
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/35.png
      awayScore: 0
      moreInfoLink: https://onefootball.com/en/match/2470842
    ,       homeTeamName: Peru
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/127.png
      homeScore: 0
      time: 
      league: 
      leagueLogo: 
      date: 25/06
      awayTeamName: Canada
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png
      awayScore: 1
      moreInfoLink: https://onefootball.com/en/match/2470834
    )
      awayTeamLastFixtures: (      homeTeamName: Canada
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png
      homeScore: 2
      time: 
      league: 
      leagueLogo: 
      date: 14/07
      awayTeamName: Uruguay
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png
      awayScore: 2
      moreInfoLink: https://onefootball.com/en/match/2470856
    ,       homeTeamName: Uruguay
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png
      homeScore: 0
      time: 
      league: 
      leagueLogo: 
      date: 11/07
      awayTeamName: Colombia
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/118.png
      awayScore: 1
      moreInfoLink: https://onefootball.com/en/match/2470855
    ,       homeTeamName: Uruguay
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png
      homeScore: 0
      time: 
      league: 
      leagueLogo: 
      date: 07/07
      awayTeamName: Brazil
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/79.png
      awayScore: 0
      moreInfoLink: https://onefootball.com/en/match/2470852
    ,       homeTeamName: USA
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/81.png
      homeScore: 0
      time: 
      league: 
      leagueLogo: 
      date: 02/07
      awayTeamName: Uruguay
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png
      awayScore: 1
      moreInfoLink: https://onefootball.com/en/match/2470847
    ,       homeTeamName: Uruguay
      homeTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png
      homeScore: 5
      time: 
      league: 
      leagueLogo: 
      date: 28/06
      awayTeamName: Bolivia
      awayTeamLogo: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/840.png
      awayScore: 0
      moreInfoLink: https://onefootball.com/en/match/2470838
    )
      standings: (    nameStanding: Group A
    teamPosition: (    gamesPlayed : 3
    wins : 3
    draws : 0
    lose : 0
    points : 9
    team : name: Argentina imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/55.png
    goalsDifference : 5

    ,     gamesPlayed : 3
    wins : 1
    draws : 1
    lose : 1
    points : 4
    team : name: Canada imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png
    goalsDifference : -1

    ,     gamesPlayed : 3
    wins : 0
    draws : 2
    lose : 1
    points : 2
    team : name: Chile imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/35.png
    goalsDifference : -1

    ,     gamesPlayed : 3
    wins : 0
    draws : 1
    lose : 2
    points : 1
    team : name: Peru imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/127.png
    goalsDifference : -3

    )
    ,     nameStanding: Group B
    teamPosition: (    gamesPlayed : 3
    wins : 3
    draws : 0
    lose : 0
    points : 9
    team : name: Venezuela imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/591.png
    goalsDifference : 5

    ,     gamesPlayed : 3
    wins : 1
    draws : 1
    lose : 1
    points : 4
    team : name: Ecuador imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/101.png
    goalsDifference : 1

    ,     gamesPlayed : 3
    wins : 1
    draws : 1
    lose : 1
    points : 4
    team : name: Mexico imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/69.png
    goalsDifference : 0

    ,     gamesPlayed : 3
    wins : 0
    draws : 0
    lose : 3
    points : 0
    team : name: Jamaica imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/110.png
    goalsDifference : -6

    )
    ,     nameStanding: Group C
    teamPosition: (    gamesPlayed : 3
    wins : 3
    draws : 0
    lose : 0
    points : 9
    team : name: Uruguay imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png
    goalsDifference : 8

    ,     gamesPlayed : 3
    wins : 2
    draws : 0
    lose : 1
    points : 6
    team : name: Panama imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/1022.png
    goalsDifference : 1

    ,     gamesPlayed : 3
    wins : 1
    draws : 0
    lose : 2
    points : 3
    team : name: USA imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/81.png
    goalsDifference : 0

    ,     gamesPlayed : 3
    wins : 0
    draws : 0
    lose : 3
    points : 0
    team : name: Bolivia imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/840.png
    goalsDifference : -9

    )
    ,     nameStanding: Group D
    teamPosition: (    gamesPlayed : 3
    wins : 2
    draws : 1
    lose : 0
    points : 7
    team : name: Colombia imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/118.png
    goalsDifference : 4

    ,     gamesPlayed : 3
    wins : 1
    draws : 2
    lose : 0
    points : 5
    team : name: Brazil imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/79.png
    goalsDifference : 3

    ,     gamesPlayed : 3
    wins : 1
    draws : 1
    lose : 1
    points : 4
    team : name: Costa Rica imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/98.png
    goalsDifference : -2

    ,     gamesPlayed : 3
    wins : 0
    draws : 0
    lose : 3
    points : 0
    team : name: Paraguay imageUrl: https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/47.png
    goalsDifference : -5

    )
    )
      knockout: (    fixtures : Quarter-finals
    roundName : (    status: 1(4)-1(2)
    teams: (      name: Argentina
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/55.png
      ,       name: Ecuador
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/101.png
      )
    ,     status: 1(3)-1(4)
    teams: (      name: Venezuela
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/591.png
      ,       name: Canada
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/132.png
      )
    )
    ,     fixtures : Semi-finals
    roundName : (    status: 2-0
    teams: (      name: Argentina
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/55.png
      ,       name: Canada
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/132.png
      )
    )
    ,     fixtures : Final
    roundName : (    status: 1-0
    teams: (      name: Argentina
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/55.png
      ,       name: Colombia
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/118.png
      )
    )
    ,     fixtures : Semi-finals
    roundName : (    status: 0-1
    teams: (      name: Uruguay
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/56.png
      ,       name: Colombia
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/118.png
      )
    )
    ,     fixtures : Quarter-finals
    roundName : (    status: 5-0
    teams: (      name: Colombia
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/118.png
      ,       name: Panama
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/1022.png
      )
    ,     status: 0(4)-0(2)
    teams: (      name: Uruguay
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/56.png
      ,       name: Brazil
      imageUrl: https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/79.png
      )
    )
    )
      homeTeam: 2
      homeScore: 2
      awayTeam: Team(Logo: Uruguay, https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png)
      awayScore: 2

 */