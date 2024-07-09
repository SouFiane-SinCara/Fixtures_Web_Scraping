import 'package:equatable/equatable.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/team.dart';

class Knockout extends Equatable {
  final List<Team> roundOf32;
  final List<Team> roundOf16;
  final List<Team> quarterFinals;
  final List<Team> semiFinals;
  final List<Team> theFinal;
  const Knockout({
    required this.roundOf32,
    required this.roundOf16,
    required this.quarterFinals,
    required this.semiFinals,
    required this.theFinal,
  });
  @override
  List<Object?> get props => [
        roundOf32,
        roundOf16,
        quarterFinals,
        semiFinals,
        theFinal,
      ];
}
