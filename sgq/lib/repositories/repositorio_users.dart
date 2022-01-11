import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sgq/models/users.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'dart:convert';

import 'package:sgq/utils/defs.dart';

enum StatusDadosRepositorio { vazio, disponiveis }

class RepositorioUsers with ChangeNotifier {
  final List<Users> _lista = [];
  StatusDadosRepositorio _statusDados = StatusDadosRepositorio.vazio;
  final AutenticacaoServico autenticacaoServico;

  RepositorioUsers(this.autenticacaoServico);
  bool get possuiDados => _statusDados == StatusDadosRepositorio.disponiveis;

  Uri _gerApiUrl() {
    return Uri.https(
        urlAPI, "/user.json", {'auth': autenticacaoServico.usuario?.token});
  }

  List<Users> get users {
    return (_lista);
  }

  int buscaTipo(Users user) {
    if (user.userTypeId == '-MqWY3Y2j8Qyrleru0VU' ||
        user.userTypeId == '-MqWYPF_OX9f_lBP3SMi' ||
        user.userTypeId == '-MqX3STsynWDnGdTfrhz') {
      return 1; //adm, prof ou tec
    }
    return 0;
  }

  int verificaAdm(Users user) {
    if (user.userTypeId == '-MqWY3Y2j8Qyrleru0VU') {
      return 1; //adm
    }
    return 0;
  }

  Users buscaId(String id) {
    return _lista.firstWhere((tipo) => tipo.id == id);
  }

  Users buscaEmailSenha(String email, String senha) {
    return _lista
        .firstWhere((tipo) => tipo.email == email && tipo.password == senha);
  }

  //ADD
  Future<Users> _save(Users user) async {
    //convertendo para uma string json
    final resp =
        await http.post(_gerApiUrl(), body: json.encode(user.toJson()));

    //decodificar p q possamos entender
    final data = json.decode(resp.body);

    //mudando o id
    return user.copyWith(id: data['name']);
  }

  void addUser(Users user) async {
    var u = await _save(user);
    _lista.add(u);
    notifyListeners();
  }

  //CARREGANDO DADOS
  loadRemote() async {
    _lista.clear();
    if (autenticacaoServico.logado) {
      final resp = await http.get(_gerApiUrl());

      //decodificar p q possamos entender
      final data = json.decode(resp.body);

      data.forEach((key, value) {
        value['id'] = key;
        //add na lista
        _lista.add(Users.fromJson(value));
      });
      _statusDados = StatusDadosRepositorio.disponiveis;
      notifyListeners();
    }
  }
}
