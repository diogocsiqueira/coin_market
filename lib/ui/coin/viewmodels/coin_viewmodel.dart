import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coin_market/domain/entities/coin/coin_entity.dart';
import 'package:coin_market/domain/entities/core/request_state_entity.dart';
import 'package:coin_market/data/repositories/coin/coin_repository.dart';

final class CoinViewModel extends Cubit<IRequestState<List<Coin>>> {
  final CoinRepository _repository;

  CoinViewModel(this._repository) : super(const RequestInitiationState());

  Future<void> fetchCoins({String? symbols}) async {
    _emit(const RequestProcessingState());

    try {
      final coins = await _repository.fetchCoins(symbols: symbols);
      _emit(RequestCompletedState(value: coins));
    } catch (error) {
      _emit(RequestErrorState(error: error));
    }
  }

  void _emit(IRequestState<List<Coin>> state) {
    if (isClosed) return;
    emit(state);
  }
}
