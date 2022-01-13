import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'package:sgq/widget/custom_drawer.dart';

class Lista extends StatelessWidget {
  final List lista;
  final String titulo;
  final String rota;

  const Lista(
      {Key? key, required this.lista, required this.titulo, required this.rota})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    var repUser = Provider.of<RepositorioUsers>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
          if (repUser.verificaAdm(repUser.buscaEmailSenha(
                  autenticacaoServ.usuario!.email,
                  autenticacaoServ.usuario!.senha)) ==
              1)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(rota);
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
