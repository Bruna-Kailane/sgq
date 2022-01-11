import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/cadastro_user.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'package:sgq/widget/custom_drawer.dart';

class ListaUsers extends StatelessWidget {
  static const String routeName = '/listaUsers';

  const ListaUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repUser = Provider.of<RepositorioUsers>(context);
    var autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    var lista = repUser.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
          if (repUser.verificaAdm(repUser.buscaEmailSenha(
                  autenticacaoServ.usuario!.email,
                  autenticacaoServ.usuario!.senha)) ==
              1)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CadastroUser.routeName);
                },
                icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: lista.length,
            itemBuilder: (ctx, i) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(lista[i].name),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
