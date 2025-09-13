import 'package:equatable/equatable.dart';
import 'package:watchlist_project/features/domain/entity/symbol_entity.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<SymbolEntity> symbols;

  const WatchlistLoaded(this.symbols);

  @override
  List<Object?> get props => [symbols];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}
