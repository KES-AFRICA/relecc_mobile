class Environment {
  static const String environment = String.fromEnvironment('env', defaultValue: 'staging');
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String defaultTenantId = String.fromEnvironment('DEFAULT_TENANT_ID', defaultValue: 'public');
  static const String apiKey = String.fromEnvironment('API_KEY');

  static bool get isStaging => environment == 'staging';
  static bool get isProduction => environment == 'prod';
}
