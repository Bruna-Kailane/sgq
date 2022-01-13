import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/repositories/repositorio_tipo_user.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';
import 'package:sgq/widget/formulario.dart';

class CadastroUser extends StatefulWidget {
  static const String routeName = '/cadastroUser';

  const CadastroUser({Key? key}) : super(key: key);

  @override
  State<CadastroUser> createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final formKey = GlobalKey<FormState>();
  var erro = '';
  var areaId;
  var userTypeId;

  submeter(AutenticacaoServico autenticacaoServico, String email,
      String senha) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await autenticacaoServico.signUp(email, senha);
      } on Exception catch (e) {
        setState(() {
          erro = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = '';
    String password = '';
    String email = '';
    var repositorio = Provider.of<RepositorioUsers>(context, listen: false);
    var autenticacaoServ = Provider.of<AutenticacaoServico>(context);

    var rep = Provider.of<RepositorioTipoUser>(context, listen: false);
    var tipos = rep.tipo;

    var r = Provider.of<RepositorioEducationArea>(context, listen: false);
    var areas = r.areas;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Usuário"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //salvar
                formKey.currentState!.save();
                submeter(autenticacaoServ, email, password);

                Users user = Users(
                    id: UniqueKey().toString(),
                    name: name,
                    password: password,
                    email: email,
                    userTypeId: userTypeId,
                    areaId: areaId);

                repositorio.addUser(user);

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
                label: "Nome",
                hint: "Digite o Nome do Usuario",
                icon: const Icon(Icons.text_fields),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Nome Obrigatorio";
                  }
                },
                save: (text) {
                  name = text ?? '';
                },
              ),
              const SizedBox(height: 10),
              Formulario(
                label: "Email",
                hint: "Digite o Email do Novo Usuario",
                icon: const Icon(Icons.email),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Email Obrigatorio";
                  }
                  if (!text.contains("@") || !text.contains(".")) {
                    return "Digite um e-mail valido";
                  }
                },
                save: (text) {
                  email = text ?? '';
                },
              ),
              const SizedBox(height: 10),
              Formulario(
                label: "Senha",
                hint: "Digite a Senha",
                icon: const Icon(Icons.password),
                obscureText: true,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Senha Obrigatoria";
                  }
                  if (text.length < 6) {
                    return "A senha precisa ser maior que 6 caracteres";
                  }
                },
                save: (text) {
                  password = text ?? '';
                },
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                hint: const Text("Área do Usuário"),
                value: areaId,
                focusColor: Theme.of(context).primaryColor,
                underline: Container(
                  color: Theme.of(context).primaryColor,
                  height: 2.0,
                ),
                onChanged: (newValue) {
                  setState(() {
                    areaId = newValue ?? areas.first.id;
                  });
                },
                items: areas
                    .map((area) => DropdownMenuItem<String>(
                          child: Text(area.name),
                          value: area.id,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 15),
              DropdownButton<String>(
                hint: const Text("Tipo do Usuário"),
                value: userTypeId,
                focusColor: Theme.of(context).primaryColor,
                underline: Container(
                  color: Theme.of(context).primaryColor,
                  height: 2.0,
                ),
                onChanged: (newValue) {
                  setState(() {
                    userTypeId = newValue ?? tipos.first.id;
                  });
                },
                items: tipos
                    .map((tipo) => DropdownMenuItem<String>(
                          child: Text(tipo.name),
                          value: tipo.id,
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
