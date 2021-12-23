import 'package:flutter/material.dart';
import 'package:sgq/models/education_area.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:sgq/services/autenticacao_servico.dart';
import 'dart:convert';

import 'package:sgq/utils/defs.dart';

enum StatusDadosRepositorio { vazio, disponiveis }

class RepositorioEducationArea with ChangeNotifier {
  final List<EducationArea> _lista = [];
  StatusDadosRepositorio _statusDados = StatusDadosRepositorio.vazio;
  bool get possuiDados => _statusDados == StatusDadosRepositorio.disponiveis;
  final AutenticacaoServico autenticacaoServico;
  RepositorioEducationArea(this.autenticacaoServico);

  Uri _gerApiUrl() {
    return Uri.https(
        urlAPI, "/areas.json", {'auth': autenticacaoServico.usuario?.token});
  }

  List<EducationArea> get areas {
    return UnmodifiableListView(_lista);
  }

  EducationArea buscaId(String id) {
    return _lista.firstWhere((area) => area.id == id);
  }

  //ADD
  Future<EducationArea> _save(EducationArea area) async {
    //convertendo para uma string json
    final resp =
        await http.post(_gerApiUrl(), body: json.encode(area.toJson()));

    //decodificar p q possamos entender
    final data = json.decode(resp.body);

    //mudando o id
    return area.copyWith(id: data['name']);
  }

  void addArea(EducationArea area) async {
    var a = await _save(area);
    _lista.add(a);
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
        _lista.add(EducationArea.fromJson(value));
      });
      _statusDados = StatusDadosRepositorio.disponiveis;
      notifyListeners();
    }
  }
}
