import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/education_area.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_users.dart';

class DescricaoReserva extends StatelessWidget {
  static const String routeName = "/descricaoReserva";

  const DescricaoReserva({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var repositorio = Provider.of<RepositorioReserve>(context, listen: false);
    var parametros =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var repArea = Provider.of<RepositorioEducationArea>(context, listen: false);
    var repUser = Provider.of<RepositorioUsers>(context, listen: false);

    final String id = parametros['id'];
    final reserva = repositorio.buscaId(id);

    Users autor = repUser.buscaId(reserva.authorUserId);
    EducationArea area = repArea.buscaId(autor.areaId);
    String professor = repUser.buscaId(reserva.keeperUserId).name;
    String autorizado = '';
    String status = '';
    String repete = '';

    if (reserva.keeperStatus == 0) {
      autorizado = 'ainda não aceitou o pedido';
    } else {
      autorizado = 'pedido aceito!';
    }

    if (reserva.reserveStatus == 0) {
      status = 'Aguardando Confirmação... ';
    } else {
      status = 'Reserva Confirmada!';
    }

    if (reserva.repeat == 0) {
      repete = 'Nunca';
    } else if (reserva.repeat == 1) {
      repete = 'Semanalmente';
    } else {
      repete = 'Mensalmente';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Descrição"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        color: Colors.grey[200],
        width: 500,
        height: 400,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Descrição:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(reserva.description),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Text(
                  "Autor:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(autor.name),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Area:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(area.name),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Data:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(reserva.date),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Inicio:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(reserva.begin),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Fim:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(reserva.finish),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Repete:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(repete),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Professor:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text("$professor : $autorizado "),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Status Reserva:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(status),
              ],
            )
          ],
        ),
      ),
    );
  }
}
