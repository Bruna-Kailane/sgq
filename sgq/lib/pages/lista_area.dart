import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/cadastro_area.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/widget/lista.dart';

class ListaArea extends StatelessWidget {
  static const String routeName = '/listaArea';

  const ListaArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repositorio = Provider.of<RepositorioEducationArea>(context);
    var lista = repositorio.areas;
    var rota = CadastroArea.routeName;

    return Lista(lista: lista, titulo: "Areas", rota: rota);
  }
}
