import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/user_type.dart';
import 'package:sgq/repositories/repositorio_tipo_user.dart';
import 'package:sgq/widget/formulario.dart';

class CadastroTypeUser extends StatelessWidget {
  static const String routeName = '/cadastroTypeUser';
  final formKey = GlobalKey<FormState>();

  CadastroTypeUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = '';
    String description = '';

    var repositorio = Provider.of<RepositorioTipoUser>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Tipo"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //salvar
                formKey.currentState!.save();

                UserType userType = UserType(
                    id: UniqueKey().toString(),
                    name: name,
                    description: description);

                repositorio.addTipo(userType);

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
                hint: "Digite o Nome do Novo Tipo",
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
                label: "Descrição",
                hint: "Digite a Descrição",
                icon: const Icon(Icons.text_fields),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Descrição Obrigatoria";
                  }
                },
                save: (text) {
                  description = text ?? '';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
