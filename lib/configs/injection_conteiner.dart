﻿import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:coin_market/configs/environment_helper.dart';
import 'package:coin_market/core/service/app_service.dart';
import 'package:coin_market/core/service/migrate_service.dart';
import 'package:coin_market/core/service/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  /// #region EnvironmentHelper
  final IEnvironmentHelper environmentHelper = EnvironmentHelper();
  getIt.registerSingleton<IEnvironmentHelper>(environmentHelper);

  /// #region AppService
  getIt.registerSingleton<IAppService>(AppService(GlobalKey<NavigatorState>()));

  /// #region StorageService
  getIt.registerSingleton<IStorageService>(
    StorageService(MigrateService(), await SharedPreferences.getInstance()),
  );
}
