import 'package:watchlist_project/features/domain/entity/symbol_entity.dart';

import '../../repository_impl/watchlist_repository.impl.dart';

class GetWatchlist {
  final WatchlistRepositoryImpl repository;
  GetWatchlist(this.repository);

  Future<List<SymbolEntity>> call(String group) {
    return repository.getSymbols(group);
  }
}
