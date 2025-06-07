part of 'coin_bloc.dart';

abstract class CoinEvent {}

class FetchCoinsEvent extends CoinEvent {
  final String? symbols;

  FetchCoinsEvent({this.symbols});
}
