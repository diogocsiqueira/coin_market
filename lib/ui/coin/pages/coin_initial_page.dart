import 'package:coin_market/ui/coin/viewmodels/coin_factory_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coin_market/domain/entities/coin/coin_entity.dart';
import 'package:coin_market/domain/entities/core/request_state_entity.dart';
import 'package:coin_market/ui/coin/viewmodels/coin_viewmodel.dart'; // ajuste o caminho conforme seu projeto

class CoinPage extends StatelessWidget {
  const CoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoinViewModel>(
      create: (_) => CoinFactoryViewModel().create(context),
      child: const _CoinScreenBody(),
    );
  }
}

class _CoinScreenBody extends StatefulWidget {
  const _CoinScreenBody();

  @override
  State<_CoinScreenBody> createState() => _CoinScreenBodyState();
}

class _CoinScreenBodyState extends State<_CoinScreenBody> {
  @override
  void initState() {
    super.initState();
    // Carregar as moedas assim que a tela abrir
    context.read<CoinViewModel>().fetchCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coins')),
      body: BlocBuilder<CoinViewModel, IRequestState<List<Coin>>>(
        builder: (context, state) {
          if (state is RequestProcessingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RequestErrorState) {
            return Center(
              child: Text(
                'Erro: ${state.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is RequestCompletedState<List<Coin>>) {
            final coins = state.value!;
            if (coins.isEmpty) {
              return const Center(child: Text('Nenhuma moeda encontrada'));
            }
            return ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(coin.symbol[0].toUpperCase()),
                  ),
                  title: Text(coin.symbol),
                  subtitle: Text(coin.formattedPriceBrl),
                );
              },
            );
          }

          // Estado inicial ou outros estados não tratados
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
