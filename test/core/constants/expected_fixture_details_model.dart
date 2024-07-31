import 'package:fixtures_app/features/fixtures/data/models/fixture_details_model.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_knockout.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/knockout_phase.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/standing.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/statistic.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team_position.dart';

const FixtureDetailsModel expectedFixtureDetailsModel = FixtureDetailsModel(
    matchTime: "full time",
    kickOff: "14/07/2024",
    stadium: "Bank of America Stadium",
    leagueName: "Copa América",
    tvGuide: "Mola TV (Italy)",
    statistics: [
      Statistic(
        statisticName: 'Possession',
        homeStatistic: '52%',
        awayStatistic: '48%',
      ),
      Statistic(
        statisticName: 'Total shots',
        homeStatistic: '14',
        awayStatistic: '12',
      ),
      Statistic(
        statisticName: 'Shots on target',
        homeStatistic: '6',
        awayStatistic: '5',
      ),
      Statistic(
        statisticName: 'Duels won',
        homeStatistic: '52%',
        awayStatistic: '48%',
      ),
    ],
    homeTeamLastFixtures: [
      Fixture(
          homeTeamName: "Canada",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png",
          homeScore: "2",
          time: "",
          league: "",
          leagueLogo: "",
          date: "14/07",
          awayTeamName: "Uruguay",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png",
          awayScore: "2",
          moreInfoLink: "https://onefootball.com/en/match/2470856"),
      Fixture(
          homeTeamName: "Argentina",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/55.png",
          homeScore: "2",
          time: "",
          league: "",
          leagueLogo: "",
          date: "10/07",
          awayTeamName: "Canada",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png",
          awayScore: "0",
          moreInfoLink: "https://onefootball.com/en/match/2470854"),
      Fixture(
          homeTeamName: "Venezuela",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/591.png",
          homeScore: "1",
          time: "",
          league: "",
          leagueLogo: "",
          date: "06/07",
          awayTeamName: "Canada",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png",
          awayScore: "1",
          moreInfoLink: "https://onefootball.com/en/match/2470851"),
      Fixture(
          homeTeamName: "Canada",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png",
          homeScore: "0",
          time: "",
          league: "",
          leagueLogo: "",
          date: "30/06",
          awayTeamName: "Chile",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/35.png",
          awayScore: "0",
          moreInfoLink: "https://onefootball.com/en/match/2470842"),
      Fixture(
          homeTeamName: "Peru",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/127.png",
          homeScore: "0",
          time: "",
          league: "",
          leagueLogo: "",
          date: "25/06",
          awayTeamName: "Canada",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png",
          awayScore: "1",
          moreInfoLink: "https://onefootball.com/en/match/2470834")
    ],
    awayTeamLastFixtures: [
      Fixture(
          homeTeamName: "Canada",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png",
          homeScore: "2",
          time: "",
          league: "",
          leagueLogo: "",
          date: "14/07",
          awayTeamName: "Uruguay",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png",
          awayScore: "2",
          moreInfoLink: "https://onefootball.com/en/match/2470856"),
      Fixture(
          homeTeamName: "Uruguay",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png",
          homeScore: "0",
          time: "",
          league: "",
          leagueLogo: "",
          date: "11/07",
          awayTeamName: "Colombia",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/118.png",
          awayScore: "1",
          moreInfoLink: "https://onefootball.com/en/match/2470855"),
      Fixture(
          homeTeamName: "Uruguay",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png",
          homeScore: "0",
          time: "",
          league: "",
          leagueLogo: "",
          date: "07/07",
          awayTeamName: "Brazil",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/79.png",
          awayScore: "0",
          moreInfoLink: "https://onefootball.com/en/match/2470852"),
      Fixture(
          homeTeamName: "USA",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/81.png",
          homeScore: "0",
          time: "",
          league: "",
          leagueLogo: "",
          date: "02/07",
          awayTeamName: "Uruguay",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png",
          awayScore: "1",
          moreInfoLink: "https://onefootball.com/en/match/2470847"),
      Fixture(
          homeTeamName: "Uruguay",
          homeTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png",
          homeScore: "5",
          time: "",
          league: "",
          leagueLogo: "",
          date: "28/06",
          awayTeamName: "Bolivia",
          awayTeamLogo:
              "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/164/840.png",
          awayScore: "0",
          moreInfoLink: "https://onefootball.com/en/match/2470838")
    ],
    standings: [
      Standing(nameStanding: "Group A", teamPosition: [
        TeamPosition(
            gamesPlayed: 3,
            wins: 3,
            draws: 0,
            lose: 0,
            points: 9,
            team: Team(
                name: "Argentina",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/55.png"),
            goalsDifference: 5),
        TeamPosition(
            gamesPlayed: 3,
            wins: 1,
            draws: 1,
            lose: 1,
            points: 4,
            team: Team(
                name: "Canada",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png"),
            goalsDifference: -1),
        TeamPosition(
            gamesPlayed: 3,
            wins: 0,
            draws: 2,
            lose: 1,
            points: 2,
            team: Team(
                name: "Chile",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/35.png"),
            goalsDifference: -1),
        TeamPosition(
            gamesPlayed: 3,
            wins: 0,
            draws: 1,
            lose: 2,
            points: 1,
            team: Team(
                name: "Peru",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/127.png"),
            goalsDifference: -3)
      ]),
      Standing(nameStanding: "Group B", teamPosition: [
        TeamPosition(
            gamesPlayed: 3,
            wins: 3,
            draws: 0,
            lose: 0,
            points: 9,
            team: Team(
                name: "Venezuela",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/591.png"),
            goalsDifference: 5),
        TeamPosition(
            gamesPlayed: 3,
            wins: 1,
            draws: 1,
            lose: 1,
            points: 4,
            team: Team(
                name: "Ecuador",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/101.png"),
            goalsDifference: 1),
        TeamPosition(
            gamesPlayed: 3,
            wins: 1,
            draws: 1,
            lose: 1,
            points: 4,
            team: Team(
                name: "Mexico",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/69.png"),
            goalsDifference: 0),
        TeamPosition(
            gamesPlayed: 3,
            wins: 0,
            draws: 0,
            lose: 3,
            points: 0,
            team: Team(
                name: "Jamaica",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/110.png"),
            goalsDifference: -6)
      ]),
      Standing(nameStanding: "Group C", teamPosition: [
        TeamPosition(
            gamesPlayed: 3,
            wins: 3,
            draws: 0,
            lose: 0,
            points: 9,
            team: Team(
                name: "Uruguay",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png"),
            goalsDifference: 8),
        TeamPosition(
            gamesPlayed: 3,
            wins: 2,
            draws: 0,
            lose: 1,
            points: 6,
            team: Team(
                name: "Panama",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/1022.png"),
            goalsDifference: 1),
        TeamPosition(
            gamesPlayed: 3,
            wins: 1,
            draws: 0,
            lose: 2,
            points: 3,
            team: Team(
                name: "USA",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/81.png"),
            goalsDifference: 0),
        TeamPosition(
            gamesPlayed: 3,
            wins: 0,
            draws: 0,
            lose: 3,
            points: 0,
            team: Team(
                name: "Bolivia",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/840.png"),
            goalsDifference: -9)
      ]),
      Standing(nameStanding: "Group D", teamPosition: [
        TeamPosition(
            gamesPlayed: 3,
            wins: 2,
            draws: 1,
            lose: 0,
            points: 7,
            team: Team(
                name: "Colombia",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/118.png"),
            goalsDifference: 4),
        TeamPosition(
            gamesPlayed: 3,
            wins: 1,
            draws: 2,
            lose: 0,
            points: 5,
            team: Team(
                name: "Brazil",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/79.png"),
            goalsDifference: 3),
        TeamPosition(
            gamesPlayed: 3,
            wins: 1,
            draws: 1,
            lose: 1,
            points: 4,
            team: Team(
                name: "Costa Rica",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/98.png"),
            goalsDifference: -2),
        TeamPosition(
            gamesPlayed: 3,
            wins: 0,
            draws: 0,
            lose: 3,
            points: 0,
            team: Team(
                name: "Paraguay",
                imageUrl:
                    "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/47.png"),
            goalsDifference: -5)
      ])
    ],
    knockout: [
      KnockoutPhase(roundName: "Quarter-finals", fixtures: [
        FixtureKnockout(status: "1(4)-1(2)", teams: [
          Team(
              name: "Argentina",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/55.png"),
          Team(
              name: "Ecuador",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/101.png")
        ]),
        FixtureKnockout(status: "1(3)-1(4)", teams: [
          Team(
              name: "Venezuela",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/591.png"),
          Team(
              name: "Canada",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/132.png")
        ])
      ]),
      KnockoutPhase(roundName: "Semi-finals", fixtures: [
        FixtureKnockout(status: "2-0", teams: [
          Team(
              name: "Argentina",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/55.png"),
          Team(
              name: "Canada",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/132.png")
        ])
      ]),
      KnockoutPhase(roundName: "Final", fixtures: [
        FixtureKnockout(status: "1-0", teams: [
          Team(
              name: "Argentina",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/55.png"),
          Team(
              name: "Colombia",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/118.png")
        ])
      ]),
      KnockoutPhase(roundName: "Semi-finals", fixtures: [
        FixtureKnockout(status: "0-1", teams: [
          Team(
              name: "Uruguay",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/56.png"),
          Team(
              name: "Colombia",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/118.png")
        ])
      ]),
      KnockoutPhase(roundName: "Quarter-finals", fixtures: [
        FixtureKnockout(status: "5-0", teams: [
          Team(
              name: "Colombia",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/118.png"),
          Team(
              name: "Panama",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/1022.png")
        ]),
        FixtureKnockout(status: "0(4)-0(2)", teams: [
          Team(
              name: "Uruguay",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/56.png"),
          Team(
              name: "Brazil",
              imageUrl:
                  "https://image-service.onefootball.com/transform?w=64&dpr=2&image=https://images.onefootball.com/icons/teams/56/79.png")
        ])
      ])
    ],
    homeTeam: Team(
        name: "Logo: Canada",
        imageUrl:
            "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/132.png"),
    homeScore: "2",
    awayTeam: Team(
        name: "Logo: Uruguay",
        imageUrl:
            "https://image-service.onefootball.com/transform?w=128&dpr=2&image=https://images.onefootball.com/icons/teams/164/56.png"),
    awayScore: "2");
