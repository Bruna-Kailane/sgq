import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/reserve.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/pages/descricao_reserva.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';

class PedidoReserva extends StatefulWidget {
  static const String routename = '/PedidoReserva';
  const PedidoReserva({
    Key? key,
  }) : super(key: key);

  @override
  State<PedidoReserva> createState() => _PedidoReservaState();
}

class _PedidoReservaState extends State<PedidoReserva> {
  @override
  Widget build(BuildContext context) {
    var autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    var repReserva = Provider.of<RepositorioReserve>(context);
    var repUser = Provider.of<RepositorioUsers>(context, listen: false);

    Users autor = repUser.buscaEmailSenha(
        autenticacaoServ.usuario!.email, autenticacaoServ.usuario!.senha);
    List<Reserve> lista = [];

    var adm = repUser.verificaAdm(autor);

    if (adm == 1) {
      lista = repReserva.pedidosAdm();
    } else {
      lista = repReserva.pedidos(autor.id);
    }

    excluir(Reserve reserve) {
      var id = reserve.id;

      repReserva.deleteReserva(id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
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
                      leading: IconButton(
                        onPressed: () {
                          if (adm == 1) {
                            repReserva.updateReserva(
                              lista[i].copyWith(reserveStatus: 1),
                            );
                          } else {
                            repReserva.updateReserva(
                                lista[i].copyWith(keeperStatus: 1));
                          }
                          lista.clear();
                          setState(() {
                            lista = repReserva.pedidos(autor.id);
                          });
                        },
                        icon: const Icon(Icons.check),
                      ),
                      title: Text(lista[i].description),
                      trailing: IconButton(
                        onPressed: () {
                          excluir(lista[i]);
                        },
                        icon: Icon(Icons.delete),
                      ),
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
