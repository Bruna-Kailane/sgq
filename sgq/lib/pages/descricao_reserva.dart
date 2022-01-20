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

    final String id = parametros['id'];
    final reserva = repositorio.buscaId(id);

    var repUser = Provider.of<RepositorioUsers>(context, listen: false);
    Users autor = repUser.buscaId(reserva.authorUserId);

    var repArea = Provider.of<RepositorioEducationArea>(context, listen: false);
    EducationArea area = repArea.buscaId(autor.areaId);

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
          ],
        ),
      ),
    );
  }
}

  /*TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }*/