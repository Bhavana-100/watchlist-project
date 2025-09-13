import 'package:watchlist_project/features/domain/entity/symbol_entity.dart';

class SymbolModel extends SymbolEntity {
  SymbolModel({required String symbol}) : super(symbol: symbol);

  factory SymbolModel.fromJson(Map<String, dynamic> json) {
    return SymbolModel(symbol: json['symbol'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'symbol': symbol};
  }
}