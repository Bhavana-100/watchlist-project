import '../entity/symbol_entity.dart';

abstract class WatchlistRepository {
  Future<List<SymbolEntity>> getSymbols(String group);
}
