import 'package:coin_market/ui/coin/viewmodels/coin_factory_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coin_market/domain/entities/coin/coin_entity.dart';
import 'package:coin_market/domain/entities/core/request_state_entity.dart';
import 'package:coin_market/ui/coin/viewmodels/coin_viewmodel.dart';
import 'package:coin_market/core/widgets/progress_indicator_widget.dart';

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
  final TextEditingController _searchController = TextEditingController();

  Future<void> _fetchCoins() async {
    await context.read<CoinViewModel>().fetchCoins(
      symbols: _searchController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Coin Market',
          style: TextStyle(
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Digite símbolos (ex: BTC,ETH)',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.grey.shade900,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.refresh, color: Color(0xFFFFD700)),
                  onPressed: _fetchCoins,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _fetchCoins(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CoinViewModel, IRequestState<List<Coin>>>(
                builder: (context, state) {
                  if (state is RequestProcessingState) {
                    return const ProgressIndicatorWidget();
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
                      return const Center(
                        child: Text(
                          'Nenhuma moeda encontrada',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: coins.length,
                      itemBuilder: (context, index) {
                        final coin = coins[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFFFD700),
                            child: Text(
                              coin.symbol[0].toUpperCase(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          title: Text(
                            coin.symbol,
                            style: const TextStyle(
                              color: Color(0xFFFFD700),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            coin.formattedPriceBrl,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/coin-details',
                              arguments: coin,
                            );
                          },
                        );
                      },
                    );
                  }

                  return const Center(
                    child: Text(
                      'Nenhuma moeda carregada.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
