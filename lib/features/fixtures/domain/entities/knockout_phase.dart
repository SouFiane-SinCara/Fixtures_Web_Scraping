import 'package:equatable/equatable.dart';
import 'package:fixtures_app/features/fixtures/domain/entities/fixture_knockout.dart';

class KnockoutPhase extends Equatable {
  final String roundName;
  final List<FixtureKnockout> fixtures;
  const KnockoutPhase({
    required this.roundName,
    required this.fixtures,
  });
  String printDetails() {
    return '''
    fixtures : $roundName
    roundName : ${fixtures.map(
      (e) => e.printDetails(),
    )}
    ''';
  }

  @override
  List<Object?> get props => [roundName, fixtures];
}
