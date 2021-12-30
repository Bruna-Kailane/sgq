import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:sgq/models/reserve.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'dart:convert';

import 'package:sgq/utils/defs.dart';

enum StatusDadosRepositorio { vazio, disponiveis }

class RepositorioReserve with ChangeNotifier {
  final List<Reserve> _lista = [];

  StatusDadosRepositorio _statusDados = StatusDadosRepositorio.vazio;

  bool get possuiDados => _statusDados == StatusDadosRepositorio.disponiveis;
  final AutenticacaoServico autenticacaoServico;
  RepositorioReserve(this.autenticacaoServico);

  Uri _gerApiUrl() {
    return Uri.https(
        urlAPI, "/reserve.json", {'auth': autenticacaoServico.usuario?.token});
  }

  List<Reserve> get tipo {
    return UnmodifiableListView(_lista);
  }

  Reserve buscaId(String id) {
    return _lista.firstWhere((tipo) => tipo.id == id);
  }

  //ADD
  Future<Reserve> _save(Reserve reserva) async {
    //convertendo para uma string json
    final resp =
        await http.post(_gerApiUrl(), body: json.encode(reserva.toJson()));

    //decodificar p q possamos entender
    final data = json.decode(resp.body);

    //mudando o id
    return reserva.copyWith(id: data['name']);
  }

  void addReserva(Reserve reserve) async {
    var r = await _save(reserve);
    _lista.add(r);
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
        _lista.add(Reserve.fromJson(value));
      });
      _statusDados = StatusDadosRepositorio.disponiveis;
      notifyListeners();
    }
  }
}
