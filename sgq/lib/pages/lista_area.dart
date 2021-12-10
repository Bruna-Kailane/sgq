import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/cadastro_area.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/widget/custom_drawer.dart';

class ListaArea extends StatelessWidget {
  static const String routeName = '/listaArea';

  const ListaArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repositorio = Provider.of<RepositorioEducationArea>(context);
    var lista = repositorio.areas;

    if (!repositorio.possuiDados) {
      repositorio.loadRemote();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Areas"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CadastroArea.routeName);
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
