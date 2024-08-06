// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Statistic extends Equatable {
  final String statisticName;
  final String homeStatistic;
  final String awayStatistic;
  const Statistic({
    required this.statisticName,
    required this.homeStatistic,
    required this.awayStatistic,
  });
  String printWithDetails() {
    return '''
    statisticName : $statisticName
    homeStatistic : $homeStatistic
    awayStatistic : $awayStatistic
    ''';
  }

  @override
  List<Object> get props => [statisticName, homeStatistic, awayStatistic];
}
