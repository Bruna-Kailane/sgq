import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/reserve.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/pages/home.dart';
import 'package:sgq/pages/lista_area.dart';
import 'package:sgq/pages/lista_type_user.dart';
import 'package:sgq/pages/lista_users.dart';
import 'package:sgq/pages/pedido_reserva.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'package:sgq/widget/badge.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    var repUser = Provider.of<RepositorioUsers>(context, listen: false);
    var repReserva = Provider.of<RepositorioReserve>(context);

    Users autor = repUser.buscaEmailSenha(
        autenticacaoServ.usuario!.email, autenticacaoServ.usuario!.senha);
    //se for prof, adm ou tecnico retorna 1- se for aluno retorna 0
    int status = repUser.buscaTipo(autor);

    List<Reserve> lista = repReserva.pedidos(autor.id);

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
          if (status == 1)
            Badge(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(PedidoReserva.routename);
                  },
                  title: const Text("Pedidos"),
                ),
                value: lista.length.toString(),
                color: Colors.amber),
        ],
      ),
    );
  }
}
