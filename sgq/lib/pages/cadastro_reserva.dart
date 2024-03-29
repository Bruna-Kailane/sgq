import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/reserve.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'package:intl/intl.dart';
import 'package:sgq/widget/formulario.dart';

class CadastroReserva extends StatefulWidget {
  static const String routeName = '/cadastroReserva';

  const CadastroReserva({Key? key}) : super(key: key);

  @override
  State<CadastroReserva> createState() => _CadastroReservaState();
}

class _CadastroReservaState extends State<CadastroReserva> {
  final formKey = GlobalKey<FormState>();
  String descricao = '';
  DateTime data = DateTime.now();
  TimeOfDay begin = TimeOfDay.now();
  TimeOfDay finish = TimeOfDay.now();
  var repete = 0;
  int numRepete = 0;
  var keeperUserId;

  Future selecionarData(BuildContext context) async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (dataSelecionada != null) {
      setState(() {
        data = dataSelecionada;
      });
    }
    return Future<void>.value();
  }

  String getText(int cod, String text) {
    var hours = '';
    var minutes = '';

    if (cod == 0) {
      hours = begin.hour.toString().padLeft(2, '0');
      minutes = begin.minute.toString().padLeft(2, '0');
    } else {
      hours = finish.hour.toString().padLeft(2, '0');
      minutes = finish.minute.toString().padLeft(2, '0');
    }
    return 'Seleciona a hora de $text: $hours:$minutes';
  }

  Future pickTime(BuildContext context, int cod) async {
    if (cod == 0) {
      final newTime = await showTimePicker(
        context: context,
        initialTime: begin,
      );

      if (newTime == null) return;

      setState(() => begin = newTime);
    } else {
      final newTime = await showTimePicker(
        context: context,
        initialTime: finish,
      );

      if (newTime == null) return;

      setState(() => finish = newTime);
    }

    return Future<void>.value();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    var autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    var repositorioReserva =
        Provider.of<RepositorioReserve>(context, listen: false);
    var repUser = Provider.of<RepositorioUsers>(context, listen: false);
    var profs = repUser.profTec();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    Users autor = repUser.buscaEmailSenha(
        autenticacaoServ.usuario!.email, autenticacaoServ.usuario!.senha);
    //se for prof, adm ou tecnico retorna 1- se for aluno retorna 0
    int status = repUser.buscaTipo(autor);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reserva"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //salvar
                formKey.currentState!.save();

                String dataString = dateFormat.format(data);
                String beginString = formatTimeOfDay(begin);
                String finishString = formatTimeOfDay(finish);

                Reserve reserve = Reserve(
                    id: UniqueKey().toString(),
                    date: dataString,
                    begin: beginString,
                    finish: finishString,
                    description: descricao,
                    authorUserId: autor.id,
                    keeperUserId: keeperUserId,
                    keeperStatus: status,
                    reserveStatus: 0,
                    repeat: repete,
                    numRepeat: numRepete);

                if (repete == 1) {
                  for (var i = 0; i < numRepete; i++) {
                    repositorioReserva.addReserva(reserve);
                    setState(() {
                      data = data.add(Duration(days: 7));
                    });
                    dataString = dateFormat.format(data);
                    reserve.date = dataString;
                  }
                } else if (repete == 2) {
                  for (var i = 0; i < numRepete; i++) {
                    repositorioReserva.addReserva(reserve);
                    setState(() {
                      data = data.add(Duration(days: 30));
                    });
                    dataString = dateFormat.format(data);
                    reserve.date = dataString;
                  }
                } else {
                  repositorioReserva.addReserva(reserve);
                }

                //voltar p home
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.save_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Formulario(
                label: "Descrição",
                hint: "O que será feito - Quantas pessoas",
                icon: const Icon(Icons.text_fields),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Descrição Obrigatorio";
                  }
                },
                save: (text) {
                  descricao = text ?? '';
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Selecione uma data: ${DateFormat("dd/MM/yyyy").format(data)}",
                  ),
                  TextButton(
                    onPressed: () {
                      selecionarData(context);
                    },
                    child: const Icon(Icons.calendar_today),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(getText(0, 'inicio')),
                  TextButton(
                    onPressed: () {
                      pickTime(context, 0);
                    },
                    child: const Icon(Icons.watch_later),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(getText(1, 'fim')),
                  TextButton(
                    onPressed: () {
                      pickTime(context, 1);
                    },
                    child: const Icon(Icons.watch_later),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                hint: const Text("Professor Responsavel"),
                value: keeperUserId,
                focusColor: Theme.of(context).primaryColor,
                underline: Container(
                  color: Theme.of(context).primaryColor,
                  height: 2.0,
                ),
                onChanged: (newValue) {
                  setState(() {
                    keeperUserId = newValue ?? profs.first.id;
                  });
                },
                items: profs
                    .map((tipo) => DropdownMenuItem<String>(
                          child: Text(tipo.name),
                          value: tipo.id,
                        ))
                    .toList(),
              ),
              if (status == 1)
                Column(
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                            value: 0,
                            onChanged: (newValue) {
                              setState(() {
                                repete = newValue!;
                              });
                            },
                            groupValue: repete),
                        const Text("Nunca"),
                        Radio<int>(
                            value: 1,
                            onChanged: (newValue) {
                              setState(() {
                                repete = newValue!;
                              });
                            },
                            groupValue: repete),
                        const Text("Semanalmente"),
                        Radio<int>(
                            value: 2,
                            onChanged: (newValue) {
                              setState(() {
                                repete = newValue!;
                              });
                            },
                            groupValue: repete),
                        const Text("Mensalmente"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (repete > 0)
                      Formulario(
                        label: "Numero de repetições",
                        hint: "Por quantas semanas/meses será repetido",
                        icon: const Icon(Icons.text_fields),
                        keyboardType: TextInputType.number,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Obrigatorio";
                          }
                          int? valor = int.tryParse(text);

                          if (valor == null || valor <= 0) {
                            return "Valor inválido!";
                          }
                        },
                        save: (text) {
                          numRepete = int.parse(text ?? '0');
                        },
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
