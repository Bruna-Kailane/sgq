import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:sgq/models/users.dart';
import 'dart:convert';

import 'package:sgq/utils/defs.dart';

enum StatusDadosRepositorio { vazio, disponiveis }

class RepositorioUsers with ChangeNotifier {
  final List<Users> _lista = [];

  StatusDadosRepositorio _statusDados = StatusDadosRepositorio.vazio;
  bool get possuiDados => _statusDados == StatusDadosRepositorio.disponiveis;

  Uri _gerApiUrl() {
    return Uri.https(
      urlAPI,
      "/user.json", /* {'auth': autenticacaoServico.usuario?.token}*/
    );
  }

  List<Users> get users {
    return UnmodifiableListView(_lista);
  }

  Users buscaId(String id) {
    return _lista.firstWhere((tipo) => tipo.id == id);
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
