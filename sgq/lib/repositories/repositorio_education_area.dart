import 'package:flutter/material.dart';
import 'package:sgq/models/education_area.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sgq/utils/defs.dart';

class RepositorioEducationArea with ChangeNotifier {
  List<EducationArea> _lista = [];

  Uri _gerApiUrl() {
    return Uri.https(
      urlAPI,
      "/areas.json", /* {'auth': autenticacaoServico.usuario?.token}*/
    );
  }

  List<EducationArea> get areas {
    return UnmodifiableListView(_lista);
  }

  EducationArea buscaId(String id) {
    return _lista.firstWhere((area) => area.id == id);
  }

  //ADD
  Future<EducationArea> _save(EducationArea area) async {
    //convertendo a receita para uma string json
    final resp =
        await http.post(_gerApiUrl(), body: json.encode(area.toJson()));

    //decodificar p q possamos entender
    final data = json.decode(resp.body);

    //mudando o id da receita
    return area.copyWith(id: data['name']);
  }

  void addArea(EducationArea area) async {
    var a = await _save(area);
    _lista.add(a);
    notifyListeners();
  }
}
