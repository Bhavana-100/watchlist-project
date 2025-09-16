import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_project/core/utils/constants.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    await Future.delayed(const Duration(milliseconds: 300)); 
    final results = Constants.allSymbols
    .where((e) => e.toLowerCase().contains(event.query.toLowerCase()))
    .toList();

    if (results.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchLoaded(results));
    }
  }
}