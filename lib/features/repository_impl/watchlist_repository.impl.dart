import 'package:watchlist_project/features/data/datasource/mock_watchlist_data.dart';
import 'package:watchlist_project/features/domain/entity/symbol_entity.dart';
import 'package:watchlist_project/features/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final MockWatchlistDataSource dataSource;

  WatchlistRepositoryImpl({required this.dataSource});

  @override
  Future<List<SymbolEntity>> getSymbols(String group) async {
    return await dataSource.getSymbolsForGroup(group);
  }
}
