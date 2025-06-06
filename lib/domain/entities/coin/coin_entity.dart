import 'package:intl/intl.dart';

class Coin {
  final String name;
  final String symbol;
  final DateTime dateAdded;
  final double priceUsd;
  final double? priceBrl;

  Coin({
    required this.name,
    required this.symbol,
    required this.dateAdded,
    required this.priceUsd,
    this.priceBrl,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    final quote = json['quote'] as Map<String, dynamic>;

    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      dateAdded: DateTime.parse(json['date_added']),
      priceUsd: (quote['USD']?['price'] ?? 0).toDouble(),
      priceBrl:
          quote.containsKey('BRL')
              ? (quote['BRL']?['price'] ?? 0).toDouble()
              : null,
    );
  }

  String get formattedPriceUsd =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'US\$').format(priceUsd);

  String get formattedPriceBrl =>
      priceBrl != null
          ? NumberFormat.currency(
            locale: 'pt_BR',
            symbol: 'R\$',
          ).format(priceBrl)
          : '—';
}
