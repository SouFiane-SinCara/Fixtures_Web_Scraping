import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fixture_search_state.dart';

class FixtureSearchCubit extends Cubit<FixtureSearchState> {
  String searchInput = '';
  FixtureSearchCubit() : super(FixtureSearchInitial());
  void search(String search) {
    emit(FixtureSearchInitial());
    searchInput = search;
    emit(UpdateFixtureSearchState(searchInput: search));
  }
}
