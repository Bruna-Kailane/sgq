import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/education_area.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';

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

class Formulario extends StatelessWidget {
  final String label;
  final String hint;
  final Icon? icon;
  final String? Function(String?)? validator;
  final Function(String?)? save;

  const Formulario({
    Key? key,
    required this.label,
    required this.hint,
    this.icon,
    this.validator,
    this.save,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: save,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
    );
  }
}
