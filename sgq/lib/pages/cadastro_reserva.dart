import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/reserve.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'package:intl/intl.dart';

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
  }

  String getText(int cod) {
    var hours = '';
    var minutes = '';

    if (cod == 0) {
      hours = begin.hour.toString().padLeft(2, '0');
      minutes = begin.minute.toString().padLeft(2, '0');
    } else {
      hours = finish.hour.toString().padLeft(2, '0');
      minutes = finish.minute.toString().padLeft(2, '0');
    }
    return 'Seleciona a hora de inicio: $hours:$minutes';
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
  }

  @override
  Widget build(BuildContext context) {
    var autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    var repositorioReserva =
        Provider.of<RepositorioReserve>(context, listen: false);
    var repUser = Provider.of<RepositorioUsers>(context, listen: false);
    List<Users> ru = [];

    for (var user in repUser.users) {
      if (user.userTypeId == '-MqWYPF_OX9f_lBP3SMi' ||
          user.userTypeId == '-MqX3STsynWDnGdTfrhz') {
        ru.add(user);
      }
    }
    Users keeperUserId = ru.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reserva"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //salvar
                formKey.currentState!.save();

                Reserve reserve = Reserve(
                    id: UniqueKey().toString(),
                    date: data,
                    begin: begin,
                    finish: finish,
                    description: descricao,
                    authorUserId: repUser
                        .buscaEmailSenha(autenticacaoServ.usuario!.email,
                            autenticacaoServ.usuario!.senha)
                        .id,
                    keeperUserId: keeperUserId.id,
                    keeperStatus: repUser.buscaTipo(repUser.buscaEmailSenha(
                        autenticacaoServ.usuario!.email,
                        autenticacaoServ.usuario!.senha)),
                    reserveStatus: 0,
                    repeat: 0);

                repositorioReserva.addReserva(reserve);

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
                  Text(getText(0)),
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
                  Text(getText(1)),
                  TextButton(
                    onPressed: () {
                      pickTime(context, 1);
                    },
                    child: const Icon(Icons.watch_later),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButton<Users>(
                value: keeperUserId,
                focusColor: Theme.of(context).primaryColor,
                underline: Container(
                  color: Theme.of(context).primaryColor,
                  height: 2.0,
                ),
                onChanged: (newValue) {
                  setState(() {
                    keeperUserId = newValue ?? ru.first;
                  });
                },
                items: ru
                    .map((tipo) => DropdownMenuItem<Users>(
                          child: Text(tipo.name),
                          value: tipo,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  final String label;
  final String hint;
  final Icon? icon;
  final String? Function(String?)? validator;
  final Function(String?)? save;
  final bool obscureText;

  const Formulario({
    Key? key,
    required this.label,
    required this.hint,
    this.icon,
    this.validator,
    this.save,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: save,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
    );
  }
}
