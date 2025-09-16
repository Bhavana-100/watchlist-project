import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_project/features/domain/entity/symbol_entity.dart';
import 'package:watchlist_project/features/domain/usecase/new_watchlist.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist getWatchlist;

  WatchlistBloc({required this.getWatchlist}) : super(WatchlistInitial()) {
    on<ChangeGroup>(_onChangeGroup);
  }

  Future<void> _onChangeGroup(
    ChangeGroup event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
    try {
      final symbols = await getWatchlist(event.group);
      emit(WatchlistLoaded(symbols));
    } catch (e) {
      emit(WatchlistError('Failed to load watchlist: ${e.toString()}'));
    }
  }

}
