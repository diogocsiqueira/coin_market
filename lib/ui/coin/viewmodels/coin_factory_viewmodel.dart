import 'package:coin_market/configs/factory_viewmodel.dart';
import 'package:coin_market/data/repositories/coin/coin_repository.dart';
import 'package:coin_market/ui/coin/viewmodels/coin_viewmodel.dart';

class CoinFactoryViewModel implements IFactoryViewModel<CoinViewModel> {
  @override
  CoinViewModel create(BuildContext context) {
    final repo = getIt<CoinRepository>();
    return CoinViewModel(repo);
  }

  @override
  void dispose(BuildContext context, CoinViewModel viewModel) {
    viewModel.close();
  }
}
