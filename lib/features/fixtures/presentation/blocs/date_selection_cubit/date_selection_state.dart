part of 'date_selection_cubit.dart';

sealed class DateSelectionState extends Equatable {
  const DateSelectionState();

  @override
  List<Object> get props => [];
}

final class DateSelectionInitial extends DateSelectionState {}

final class DateSelectionUpdate extends DateSelectionState {
  final DateTime dateTime;

  const DateSelectionUpdate({required this.dateTime});
}
