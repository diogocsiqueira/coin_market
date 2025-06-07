import 'package:coin_market/configs/factory_viewmodel.dart';
import 'package:coin_market/data/repositories/coin/coin_repository.dart';
import 'package:coin_market/ui/coin/viewmodels/coin_viewmodel.dart';
import 'package:coin_market/data/datasources/core/data_source_factory.dart';
import 'package:coin_market/data/datasources/core/remote_datasource.dart';

class CoinFactoryViewModel implements IFactoryViewModel<CoinViewModel> {
  @override
  CoinViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource =
        RemoteFactoryDataSource().create();
    final CoinRepository coinRepository = CoinRepository(
      remoteDataSource as RemoteDataSource,
    );
    return CoinViewModel(coinRepository);
  }

  @override
  void dispose(BuildContext context, CoinViewModel viewModel) {
    viewModel.close();
  }
}
