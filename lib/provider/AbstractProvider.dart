import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialgist/Login.dart';
import 'package:socialgist/model/AbstractModel.dart';
import 'package:socialgist/model/ApiUsage.dart';
import 'package:socialgist/util/Config.dart';

///
/// https://developer.github.com/v3/#pagination
///
abstract class AbstractProvider<T extends AbstractModel> {
  BuildContext _context;

  /// Note that page numbering is 1-based and that omitting the ?page
  /// parameter will return the first page.
  int _page;

  // ignore: unused_field
  int _first;

  // ignore: unused_field
  int _prev;

  //
  int _next;

  //
  int _last;

  /// up to 100
  int _perPage;

  String _endpoint;

  T _model;

  Map<String, String> _headers;

  ///
  ///
  ///
  AbstractProvider({
    @required BuildContext context,
    @required String endpoint,
    @required T model,
    int page,
    int perPage,
  }) {
    _context = context;
    _endpoint = endpoint;
    _model = model;
    _page = page;
    _perPage = perPage;
    _headers = {};

    /// https://developer.github.com/v3/#current-version
    _headers['Accept'] = 'application/vnd.github.v3+json';

    /// https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/#3-use-the-access-token-to-access-the-api
    _headers['Authorization'] = 'token ${Config().token}';

    /// Refused to set unsafe header "User-Agent"
    if (!Config().isWeb) {
      /// https://developer.github.com/v3/#user-agent-required
      _headers['User-Agent'] = 'SocialGist';
    }
  }

  ///
  ///
  ///
  bool get hasNext =>
      _next != null &&
      _next > 0 &&
      _last != null &&
      (_page ?? 1) < _last &&
      _next <= _last;

  ///
  ///
  ///
  Uri _internalUri(List<String> paths, Map<String, String> qs) {
    String path = '';

    if (paths.isNotEmpty) {
      path = '/' + paths.join('/');
    }

    Uri uri = Uri.parse('${Config().rootEndpoint}/$_endpoint$path');

    Map<String, String> queryParameters = {};

    if (qs != null && qs.isNotEmpty) {
      queryParameters.addAll(qs);
    }

    if (_page != null && _page > 0) {
      queryParameters['page'] = _page.toString();
    }

    if (_perPage != null && _perPage > 0) {
      queryParameters['per_page'] = _perPage.toString();
    }

    if (queryParameters.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParameters);
    }

    if (Config().debug) print('Uri: $uri');

    return uri;
  }

  ///
  ///
  ///
  Future<dynamic> _internalGet(
    List<String> path,
    Map<String, String> qs,
  ) async {
    Uri uri = _internalUri(path, qs);

    http.Response response = await http.get(
      uri,
      headers: _headers,
    );

    if (response.statusCode != 200 && Config().debug) {
      print('Get Status Code: ${response.statusCode}');
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      var errorBody = json.decode(response.body);
      String message = errorBody['message'] ?? 'Unknown error.';

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.clear();

      await Navigator.of(_context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(
            message: '$message. (${response.statusCode})',
            authAgain: response.statusCode == 401,
          ),
        ),
        (_) => false,
      );
      return;
    }

    Map<String, String> headers = response.headers;

//    print('Headers:');
//    headers.forEach((key, value) => print('$key => $value'));

    Config().apiUsage = ApiUsage(
      limit: headers['x-ratelimit-limit'],
      remaining: headers['x-ratelimit-remaining'],
      reset: headers['x-ratelimit-reset'],
    );

    /// https://developer.github.com/v3/#conditional-requests
//    if (headers.containsKey('etag')) {
//      // TODO - We'll need a database.
//      String etag = headers['etag'];
//      print('etag: $etag - uri: $uri');
//    }

    if (headers.containsKey('link')) {
      List<String> links = headers['link'].split(',');

      for (String link in links) {
        List<String> parts = link.split(';');

        if (parts.length > 1) {
          String url = parts[0].trim();
          url = url.substring(1, url.length - 1);

          Uri uri = Uri.parse(url);
          int number = int.parse(uri.queryParameters['page']);

          String name = parts[1].trim();

          if (number != null) {
            switch (name) {
              case 'rel="first"':
                _first = number;
                break;
              case 'rel="prev"':
                _prev = number;
                break;
              case 'rel="next"':
                _next = number;
                break;
              case 'rel="last"':
                _last = number;
                break;
            }
          }
        }
      }
    }

    var body = json.decode(response.body);

//    print('Body:');

//    debugPrint(response.body, wrapWidth: 120);

//    if (body is Map) {
//      body.forEach((key, value) => print('$key => $value'));
//    } else if (body is List) {
//      body.forEach((item) => print('$item'));
//    }
    return body;
  }

  ///
  ///
  ///
  @protected
  Future<T> getObject({
    List<String> path = const [],
    Map<String, String> qs = const {},
  }) async {
    Map<String, dynamic> body = await _internalGet(path, qs);
    return _model.fromJson(body);
  }

  ///
  ///
  ///
  @protected
  Future<List<B>> typedList<B extends AbstractModel>({
    List<String> path = const [],
    Map<String, String> qs = const {},
    @required B model,
  }) async {
    _page = null;
    List list = await _internalGet(path, qs);
    return list.map<B>((body) => model.fromJson(body)).toList();
  }

  ///
  ///
  ///
  @protected
  Future<List<T>> getList({
    List<String> path = const [],
    Map<String, String> qs = const {},
  }) async {
    return typedList<T>(
      path: path,
      qs: qs,
      model: _model,
    );
  }

  ///
  ///
  ///
  @protected
  Future<List<B>> typedNextList<B extends AbstractModel>({
    List<String> path = const [],
    Map<String, String> qs = const {},
    @required B model,
  }) async {
    if (!hasNext) return null;
    _page ??= 1;
    _page++;
    List list = await _internalGet(path, qs);
    return list.map<B>((body) => model.fromJson(body)).toList();
  }

  ///
  ///
  ///
  @protected
  Future<List<T>> getNextList({
    List<String> path = const [],
    Map<String, String> qs = const {},
  }) async {
    return typedNextList<T>(
      path: path,
      qs: qs,
      model: _model,
    );
  }

  ///
  ///
  ///
  @protected
  Future<bool> put({
    List<String> path = const [],
    Map<String, String> qs = const {},
  }) async {
    Map<String, String> headers = Map.from(_headers);

    headers['Content-Length'] = '0';

    http.Response response = await http.put(
      _internalUri(path, qs),
      headers: headers,
    );

    return response.statusCode == 204;
  }

  ///
  ///
  ///
  @protected
  Future<bool> delete({
    List<String> path = const [],
    Map<String, String> qs = const {},
  }) async {
    Map<String, String> headers = Map.from(_headers);

    headers['Content-Length'] = '0';

    http.Response response = await http.delete(
      _internalUri(path, qs),
      headers: headers,
    );

    return response.statusCode == 204;
  }

  ///
  ///
  ///
  @protected
  Future<bool> check({
    List<String> path = const [],
    Map<String, String> qs = const {},
  }) async {
    Map<String, String> headers = Map.from(_headers);

    headers['Content-Length'] = '0';

    http.Response response = await http.get(
      _internalUri(path, qs),
      headers: headers,
    );

    return response.statusCode == 204;
  }
}
