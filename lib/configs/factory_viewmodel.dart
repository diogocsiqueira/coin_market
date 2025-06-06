import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:coin_market/configs/environment_helper.dart';
export 'package:coin_market/configs/injection_conteiner.dart';
export 'package:coin_market/data/datasources/core/data_source.dart';
export 'package:coin_market/data/datasources/core/non_relational_datasource.dart';
export 'package:coin_market/data/datasources/core/relational_datasource.dart';
export 'package:coin_market/core/service/app_service.dart';
export 'package:coin_market/core/service/clock_helper.dart';
export 'package:coin_market/core/service/storage_service.dart';

abstract interface class IFactoryViewModel<T> {
  T create(BuildContext context);
  void dispose(BuildContext context, T viewModel);
}
