import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:sgq/models/user_type.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'dart:convert';

import 'package:sgq/utils/defs.dart';

enum StatusDadosRepositorio { vazio, disponiveis }

class RepositorioTipoUser with ChangeNotifier {
  final List<UserType> _lista = [];

  StatusDadosRepositorio _statusDados = StatusDadosRepositorio.vazio;

  bool get possuiDados => _statusDados == StatusDadosRepositorio.disponiveis;
  final AutenticacaoServico autenticacaoServico;
  RepositorioTipoUser(this.autenticacaoServico);

  Uri _gerApiUrl() {
    return Uri.https(
        urlAPI, "/typeUser.json", {'auth': autenticacaoServico.usuario?.token});
  }

  List<UserType> get tipo {
    return UnmodifiableListView(_lista);
  }

  UserType buscaId(String id) {
    return _lista.firstWhere((tipo) => tipo.id == id);
  }

  //ADD
  Future<UserType> _save(UserType tipo) async {
    //convertendo para uma string json
    final resp =
        await http.post(_gerApiUrl(), body: json.encode(tipo.toJson()));

    //decodificar p q possamos entender
    final data = json.decode(resp.body);

    //mudando o id
    return tipo.copyWith(id: data['name']);
  }

  void addTipo(UserType tipo) async {
    var t = await _save(tipo);
    _lista.add(t);
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
        _lista.add(UserType.fromJson(value));
      });
      _statusDados = StatusDadosRepositorio.disponiveis;
      notifyListeners();
    }
  }
}
