import 'package:coin_market/data/datasources/core/remote_datasource.dart';
import 'package:coin_market/domain/entities/coin/coin_entity.dart';

class CoinRepository {
  final RemoteDataSource _remote;

  CoinRepository(this._remote);

  static const _defaultSymbols =
      'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO';

  Future<List<Coin>> fetchCoins({String? symbols}) async {
    final symbolQuery =
        (symbols?.isNotEmpty ?? false) ? symbols! : _defaultSymbols;

    final url =
        '${_remote.environment.baseUrl}/v2/cryptocurrency/quotes/latest?symbol=$symbolQuery';

    final headers = {
      "Accepts": "application/json",
      "X-CMC_PRO_API_KEY": "0593c312-8754-462e-8082-8968cfee45aa",
    };

    final response = await _remote.getWithHeaders(url, headers);

    if (response.statusCode == 200 && response.data != null) {
      final Map<String, dynamic> coinsMap = response.data['data'];
      return coinsMap.values.map((json) => Coin.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar moedas: ${response.statusCode}');
    }
  }
}
