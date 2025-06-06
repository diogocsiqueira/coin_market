import 'package:flutter/material.dart';
import 'package:coin_market/configs/injection_conteiner.dart';
import 'package:coin_market/core/service/app_service.dart';
import 'package:coin_market/ui/coin/pages/coin_initial_page.dart';

final class RouteGeneratorHelper {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    return switch (settings.name) {
      kInitial => createRoutePage(const CoinPage()),
      _ => createRouteError(),
    };
  }

  static PageRoute createRoutePage(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> createRouteError() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(body: Center(child: Text('Error Route')));
      },
    );
  }

  static const String kInitial = '/';

  static void onRouteInitialization(String route) {
    if (route.isNotEmpty) {
      getIt<IAppService>().navigateNamedReplacementTo(route);
    }
  }
}
