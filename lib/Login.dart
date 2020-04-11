import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'util/Config.dart';
import 'util/WaitingMessage.dart';
import 'view/Home.dart';
import 'widgets/SocialGistLogo.dart';

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
      _controller.add(Status.login);
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
          Expanded(
            child: StreamBuilder<Status>(
              initialData: Status.init,
              stream: _controller.stream,
              builder: (context, snapshot) {
                switch (snapshot.data) {

                  /// init
                  case Status.init:
                    return WaitingMessage('Aguarde...');

                  /// login
                  case Status.login:
                    return Center(
                      child: RaisedButton(
                        child: Text('Autorizar'),
                        onPressed: _login,
                      ),
                    );

                  /// loading
                  case Status.loading:
                    return WaitingMessage('Verificando acesso...');

                  /// error
                  case Status.error:
                    // TODO - Botão para tentar novamente.
                    return Center(
                      child: Text(
                        'Erro:\n\n$_error',
                        textAlign: TextAlign.center,
                      ),
                    );

                  /// success
                  case Status.redirecting:
                    return WaitingMessage('Redirecionando...');
                }
                return Center(
                  child: Text('Aconteceu alguma coisa que não foi prevista.'),
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
        statusBarBrightness: Brightness.dark,
      );
      _getCode(authState);
    } else {
      _error = 'Não foi possível abrir o navegador.';
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
            String token = decoded['code']['access_token'] ?? '';

            if (token.isNotEmpty) {
              await closeWebView();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', token);
              _controller.add(Status.redirecting);
              _goHome(token);
              return;
            }
          }
        }

        cont--;
        await Future.delayed(Duration(milliseconds: 3000));
      }
      _error = 'Tempo máximo excedido.';
      _controller.add(Status.error);
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
