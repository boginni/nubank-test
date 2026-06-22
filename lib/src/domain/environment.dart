final class Environment {
  const Environment._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://url-shortener-server.onrender.com/api',
  );

  static const bool isProduction = bool.fromEnvironment('IS_PRODUCTION');

  static String get ciCommitBranch => '';

  static String get ciCommitShortSha => '';

  static String get ciBuildDate => '';
}
