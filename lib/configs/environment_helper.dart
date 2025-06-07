abstract interface class IEnvironmentHelper {
  String? get baseUrl;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  @override
  String get baseUrl => 'https://pro-api.coinmarketcap.com';
}
