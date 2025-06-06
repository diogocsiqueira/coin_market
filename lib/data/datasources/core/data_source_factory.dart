import 'package:coin_market/configs/environment_helper.dart';
import 'package:coin_market/configs/injection_conteiner.dart';
import 'package:coin_market/data/datasources/core/data_source.dart';
import 'package:coin_market/data/datasources/core/relational_datasource.dart';
import 'package:coin_market/data/datasources/core/remote_datasource.dart';
import 'package:coin_market/core/service/clock_helper.dart';
import 'package:coin_market/core/service/http_service.dart';
import 'package:coin_market/core/service/storage_service.dart';
import 'package:coin_market/data/datasources/core/non_relational_datasource.dart';

final class NonRelationalFactoryDataSource {
  INonRelationalDataSource create() {
    final IStorageService storageService = getIt<IStorageService>();
    final IClockHelper clockHelper = ClockHelper();

    return NonRelationalDataSource(storageService, clockHelper);
  }
}

final class RelationalFactoryDataSource {
  IRelationalDataSource create() {
    final IStorageService storageService = getIt<IStorageService>();
    final IClockHelper clockHelper = ClockHelper();

    return RelationalDataSource(storageService, clockHelper);
  }
}

final class RemoteFactoryDataSource {
  IRemoteDataSource create() {
    final IHttpService httpService = HttpServiceFactory().create();
    final IEnvironmentHelper environmentHelper = getIt<IEnvironmentHelper>();
    final IClockHelper clockHelper = ClockHelper();
    return RemoteDataSource(httpService, environmentHelper, clockHelper);
  }
}
