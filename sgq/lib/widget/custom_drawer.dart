import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/home.dart';
import 'package:sgq/pages/lista_area.dart';
import 'package:sgq/pages/lista_type_user.dart';
import 'package:sgq/pages/lista_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autenticacaoServ = Provider.of<AutenticacaoServico>(context);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Menu Usuario"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: autenticacaoServ.logout,
                icon: const Icon(Icons.logout_outlined),
              )
            ],
          ),
          const Divider(),
          ListTile(
            onTap: () {
              //volta para o home
              Navigator.of(context).pushReplacementNamed(Home.routeName);
            },
            leading: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ListaTypeUser.routeName);
            },
            title: const Text("Tipos"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ListaArea.routeName);
            },
            title: const Text("Áreas"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ListaUsers.routeName);
            },
            title: const Text("Usuários"),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
