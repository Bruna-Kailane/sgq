import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/cadastro_user.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/widget/lista.dart';

class ListaUsers extends StatelessWidget {
  static const String routeName = '/listaUsers';

  const ListaUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repUser = Provider.of<RepositorioUsers>(context);
    var lista = repUser.users;
    var rota = CadastroUser.routeName;

    return Lista(lista: lista, titulo: "Usuários", rota: rota);
  }
}
