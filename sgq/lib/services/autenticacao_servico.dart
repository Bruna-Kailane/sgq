import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sgq/models/usuario.dart';

class AutenticacaoServico with ChangeNotifier {
  static const _urlDominio = 'identitytoolkit.googleapis.com';
  static const _apiKey = 'AIzaSyBwI0ozL6nOpuIWmgpHst5y9pNfRSHeng0';

  Usuario? _usuario;
  bool _logado = false;

  Usuario? get usuario => _usuario;
  bool get logado => _logado;

  String converterUsuario() {
    return usuario.toString();
  }

  Future<void> _signUpOrIn(String email, String senha,
      {bool cadastrar = false}) async {
    var endPoint = '';

    if (cadastrar) {
      endPoint = '/v1/accounts:signUp';
    } else {
      endPoint = '/v1/accounts:signInWithPassword';
    }

    final url = Uri.https(_urlDominio, endPoint, {'key': _apiKey});

    final resp = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': senha,
        'returnSecureToken': true,
      }),
    );

    final data = json.decode(resp.body); //decodificar

    //tratando erro
    if (resp.statusCode == 400) {
      var msg = '';
      if (cadastrar) {
        if (data['error']['message'] == 'EMAIL_EXISTS') {
          msg = 'E-mail já cadastrado';
        } else {
          msg = 'Erro!';
        }
      } else {
        msg = 'Email e/ou senha inválidos!';
      }
      throw Exception(msg);
    }

    final usuario = Usuario(
      id: data['localId'],
      email: email,
      senha: senha,
      token: data['idToken'],
      expiraEm: DateTime.now().add(
        Duration(seconds: int.parse(data['expiresIn'])),
      ),
    );

    _usuario = usuario;
    _logado = true;
    notifyListeners();
  }

  Future<void> signUp(String email, String senha) =>
      _signUpOrIn(email, senha, cadastrar: true);

  Future<void> signIn(String email, String senha) => _signUpOrIn(email, senha);

  logout() {
    _usuario = null;
    _logado = false;
    notifyListeners();
  }
}
