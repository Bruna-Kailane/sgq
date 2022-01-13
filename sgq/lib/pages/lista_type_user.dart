import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/cadastro_type_user.dart';
import 'package:sgq/repositories/repositorio_tipo_user.dart';
import 'package:sgq/widget/lista.dart';

class ListaTypeUser extends StatelessWidget {
  static const String routeName = '/listaTypeUser';

  const ListaTypeUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repositorio = Provider.of<RepositorioTipoUser>(context);
    var lista = repositorio.tipo;
    var rota = CadastroTypeUser.routeName;

    return Lista(lista: lista, titulo: "Tipo de Usuarios", rota: rota);
  }
}
