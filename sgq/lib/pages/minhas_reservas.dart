import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/reserve.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/pages/descricao_reserva.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';

class MinhasReservas extends StatefulWidget {
  static const String routename = '/minhasReservas';
  const MinhasReservas({
    Key? key,
  }) : super(key: key);

  @override
  State<MinhasReservas> createState() => _MinhasReservasState();
}

class _MinhasReservasState extends State<MinhasReservas> {
  @override
  Widget build(BuildContext context) {
    var autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    var repReserva = Provider.of<RepositorioReserve>(context);
    var repUser = Provider.of<RepositorioUsers>(context);

    Users autor = repUser.buscaEmailSenha(
        autenticacaoServ.usuario!.email, autenticacaoServ.usuario!.senha);
    List<Reserve> lista = repReserva.minhasReservas(autor.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Reservas"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: lista.length,
            itemBuilder: (ctx, i) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DescricaoReserva.routeName,
                        arguments: {'id': lista[i].id});
                  },
                  child: Card(
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(lista[i].description),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
