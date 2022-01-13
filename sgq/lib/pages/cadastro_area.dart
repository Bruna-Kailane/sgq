import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/education_area.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/widget/formulario.dart';

class CadastroArea extends StatelessWidget {
  static const String routeName = '/cadastroArea';
  final formKey = GlobalKey<FormState>();

  CadastroArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = '';

    var repositorio =
        Provider.of<RepositorioEducationArea>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Area"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //salvar
                formKey.currentState!.save();
                EducationArea educationArea =
                    EducationArea(id: UniqueKey().toString(), name: name);
                repositorio.addArea(educationArea);

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
                hint: "Digite o Nome da Nova Area",
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
            ],
          ),
        ),
      ),
    );
  }
}
