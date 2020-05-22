import 'package:socialgist/model/ApiUsage.dart';
import 'package:socialgist/model/User.dart';

///
///
///
class Config {
  static final String WEB = 'web';

  ///
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

  bool test = false;
  String testMessage;

  bool debug = true;
  String platform = 'unknown';

  final String rootEndpoint = 'https://api.github.com';

  final Uri authEndpoint =
      Uri.parse('https://github.com/login/oauth/authorize');

  final String clientId = '8bf5ac7c9627e33e206e';

  final String scope = 'user,gist';

  final Uri redirectUrl = Uri.parse(
      'https://www.strategiccore.com.br/api/socialgist/oauth2-redirect');

  final Uri codeUrl =
      Uri.parse('https://www.strategiccore.com.br/api/socialgist/oauth2-code');

  String token;

  User me;

  ApiUsage apiUsage = ApiUsage(limit: '1', remaining: '0');

  bool get isWeb => platform == WEB;
}
