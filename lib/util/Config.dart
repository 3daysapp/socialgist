class Config {
  static final Config _singleton = Config._internal();

  ///
  ///
  ///
  factory Config() {
    return _singleton;
  }

  ///
  ///
  ///
  Config._internal();

  bool debug = true;

  final Uri authEndpoint =
      Uri.parse('https://github.com/login/oauth/authorize');

  final String clientId = '8bf5ac7c9627e33e206e';

  final String scope = 'user,gist';

  final Uri redirectUrl = Uri.parse(
      'https://www.strategiccore.com.br/api/socialgist/oauth2-redirect');

  final Uri codeUrl =
      Uri.parse('https://www.strategiccore.com.br/api/socialgist/oauth2-code');

  String token;
}
