import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_project/features/presentation/bloc/home/home.state.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(currentIndex: 0)) {
    on<HomeTabChanged>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
  }
}
