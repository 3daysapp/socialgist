import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:socialgist/model/AbstractModel.dart';
import 'package:socialgist/model/ApiUsage.dart';
import 'package:socialgist/util/Config.dart';

///
/// https://developer.github.com/v3/#pagination
///
abstract class AbstractProvider<T extends AbstractModel> {
  /// Note that page numbering is 1-based and that omitting the ?page parameter will return the first page.
  int _page;

  /// up to 100
  int _perPage;

  String _endpoint;

  T _model;

  ///
  ///
  ///
  AbstractProvider({
    @required String endpoint,
    @required T model,
    int page,
    int perPage,
  }) {
    _endpoint = endpoint;
    _model = model;
    _page = page;
    _perPage = perPage;
  }

  ///
  ///
  ///
  Future<dynamic> _internalGet() async {
    String token = Config().token;
    String rootEndpoint = Config().rootEndpoint;

    Uri uri = Uri.parse('$rootEndpoint/$_endpoint');

    // TODO - Adicionar paginação.

    Response response = await get(
      uri,
      headers: {
        // https://developer.github.com/v3/#current-version
        'Accept': 'application/vnd.github.v3+json',
        // https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#3-use-the-access-token-to-access-the-api
        'Authorization': 'token $token',
        // https://developer.github.com/v3/#user-agent-required
        'User-Agent': 'SocialGist',
      },
    );

    print('Responde: ${response.statusCode}');

    // TODO - Tratamento de erros.

    Map<String, String> headers = response.headers;

    print('Headers:');
    headers.forEach((key, value) => print('$key => $value'));

    ApiUsage usage = ApiUsage(
      limit: headers['x-ratelimit-limit'],
      remaining: headers['x-ratelimit-remaining'],
      reset: headers['x-ratelimit-reset'],
    );

    print(usage);

    // debugPrint(response.body, wrapWidth: 120);

    var body = json.decode(response.body);

    print('Body:');

    if (body is Map) {
      body.forEach((key, value) => print('$key => $value'));
    } else if (body is List) {
      body.forEach((item) => print('$item'));
    }
    return body;
  }

  ///
  ///
  ///
  Future<T> getObject() async {
    Map<String, dynamic> body = await _internalGet();
    return _model.fromJson(body);
  }

  ///
  ///
  ///
  Future<List<T>> getList() async {
    List<Map<String, dynamic>> list = await _internalGet();
    return list.map((body) => _model.fromJson(body)).toList();
  }
}
