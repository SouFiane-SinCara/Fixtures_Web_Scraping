import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_selection_state.dart';

class DateSelectionCubit extends Cubit<DateSelectionState> {
  DateTime dateTime = DateTime.now();
  DateSelectionCubit() : super(DateSelectionInitial());
  void changeDate(DateTime dateTime) {
    emit(DateSelectionInitial());
    this.dateTime = dateTime;
    emit(DateSelectionUpdate(dateTime: dateTime));
  }
}
