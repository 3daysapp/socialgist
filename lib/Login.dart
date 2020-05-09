import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialgist/i18n.dart';
import 'package:socialgist/util/Config.dart';
import 'package:socialgist/util/ErrorMessage.dart';
import 'package:socialgist/util/WaitingMessage.dart';
import 'package:socialgist/view/Home.dart';
import 'package:socialgist/widgets/SocialGistLogo.dart';
import 'package:url_launcher/url_launcher.dart';

///
///
///
enum Status {
  init,
  login,
  loading,
  error,
  redirecting,
}

///
///
///
class Login extends StatefulWidget {
  final String message;
  final bool authAgain;

  ///
  ///
  ///
  const Login({
    Key key,
    this.message,
    this.authAgain = false,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _LoginState createState() => _LoginState();
}

///
///
///
class _LoginState extends State<Login> {
  final StreamController<Status> _controller = StreamController();
  String _error;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///
  ///
  ///
  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token')) {
      _controller.add(Status.redirecting);
      _goHome(prefs.getString('token'));
    } else {
      if (widget.authAgain) {
        _login();
      } else {
        _controller.add(Status.login);
      }
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SocialGistLogo(),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 128.0),
            child: SocialGistLogo(
              fontSize: 36.0,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          if (widget.message != null && widget.message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  )),
            ),
          Expanded(
            child: StreamBuilder<Status>(
              initialData: Status.init,
              stream: _controller.stream,
              builder: (context, snapshot) {
                switch (snapshot.data) {

                  /// init
                  case Status.init:
                    return WaitingMessage('Waiting...'.i18n);

                  /// login
                  case Status.login:
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'You must log in to GitHub.'.i18n,
                            textAlign: TextAlign.center,
                          ),
                          RaisedButton(
                            child: Text('Let\'s go'.i18n),
                            onPressed: _login,
                          ),
                        ],
                      ),
                    );

                  /// loading
                  case Status.loading:
                    return WaitingMessage('Verifying access...'.i18n);

                  /// error
                  case Status.error:
                    return ErrorMessage(
                      _error,
                      extras: [
                        RaisedButton(
                          child: Text('Let\'s go'.i18n),
                          onPressed: _login,
                        ),
                      ],
                    );

                  /// success
                  case Status.redirecting:
                    return WaitingMessage('Redirecting...'.i18n);
                }
                return Center(
                  child: Text('Something wrong happened.'.i18n),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  void _login() async {
    _controller.add(Status.loading);

    Config _config = Config();

    String authState = 's${DateTime.now().millisecondsSinceEpoch}g';

    Map<String, dynamic> param = {
      'client_id': _config.clientId,
      'redirect_uri': _config.redirectUrl.toString(),
      'scope': _config.scope,
      'state': authState,
    };

    String url =
        _config.authEndpoint.replace(queryParameters: param).toString();

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
//        This property creates a crash.
//        statusBarBrightness: Brightness.dark,
      );
      _getCode(authState);
    } else {
      _error = 'The browser could not be opened.'.i18n;
      _controller.add(Status.error);
    }
  }

  ///
  ///
  ///
  void _getCode(String authState) async {
    Config _config = Config();
    int cont = 30;
    Client client = Client();
    String token;

    try {
      while (cont > 0) {
        Response response = await client.post(
          _config.codeUrl.toString(),
          body: json.encode(
            {
              'state': authState,
            },
          ),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> decoded = json.decode(response.body);
          print('Decoded: $decoded');

          if (decoded['success'] ?? false) {
            token = decoded['code']['access_token'] ?? '';

            if (token.isNotEmpty) {
              if (!_config.isWeb) {
                try {
                  await closeWebView();
                } catch (exception) {
                  print('closeWebView: $exception');
                }
              }
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', token);
              cont = -1;
              break;
            }
          }
        }

        cont--;
        await Future.delayed(Duration(milliseconds: 3000));
      }

      if (token == null || token.isEmpty) {
        _error = 'Timeout reached.'.i18n;
        _controller.add(Status.error);
      } else {
        _controller.add(Status.redirecting);
        _goHome(token);
      }
    } catch (ex) {
      _error = ex.toString();
      _controller.add(Status.error);
    } finally {
      client.close();
    }
  }

  ///
  ///
  ///
  void _goHome(String token) async {
    Config().token = token;
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
      (_) => false,
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
