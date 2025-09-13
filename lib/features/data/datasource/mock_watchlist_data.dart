import '../../domain/entity/symbol_entity.dart';

class MockWatchlistDataSource {
  final Map<String, List<SymbolEntity>> _mockData = {
    "Watchlist 1": [
      SymbolEntity(symbol: "NATIONALUM"),
      SymbolEntity(symbol: "WIPRO"),
      SymbolEntity(symbol: "UPL"),
    ],
    "Watchlist 2": [
      SymbolEntity(symbol: "TCS"),
      SymbolEntity(symbol: "TECHM"),
      SymbolEntity(symbol: "INFY"),
    ],
    "Watchlist 3": [
      SymbolEntity(symbol: "TITAN"),
      SymbolEntity(symbol: "ULTRACEMCO"),
    ],
    "NIFTY": [
      SymbolEntity(symbol: "NIFTY50"),
      SymbolEntity(symbol: "BANKNIFTY"),
    ],
  };

  Future<List<SymbolEntity>> getSymbolsForGroup(String group) async {
    await Future.delayed(const Duration(milliseconds: 300)); 
    return _mockData[group] ?? [];
  }
}
