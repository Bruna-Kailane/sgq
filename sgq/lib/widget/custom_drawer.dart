import 'package:flutter/material.dart';
import 'package:sgq/pages/home_adm.dart';
import 'package:sgq/pages/lista_area.dart';
import 'package:sgq/pages/lista_type_user.dart';
import 'package:sgq/pages/lista_users.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final autenticacaoServ = Provider.of<AutenticacaoServico>(context);

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Menu Usuario"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            onTap: () {
              //volta para o home
              Navigator.of(context).pushReplacementNamed(HomeAdm.routeName);
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
        ],
      ),
    );
  }
}
