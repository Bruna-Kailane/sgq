import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/user_type.dart';
import 'package:sgq/models/users.dart';
import 'package:sgq/repositories/repositorio_tipo_user.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/widget/custom_drawer.dart';

class CadastroUser extends StatefulWidget {
  static const String routeName = '/cadastroUser';

  const CadastroUser({Key? key}) : super(key: key);

  @override
  State<CadastroUser> createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String name = '';
    String password = '';
    String email = '';

    var repositorio = Provider.of<RepositorioUsers>(context, listen: false);
    var repositorioTipo = Provider.of<RepositorioTipoUser>(context);
    var lista = repositorioTipo.tipo;
    // var autenticacaoServ = Provider.of<AutenticacaoServico>(context);
    String userTypeId = 'um';
    String areaId = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Usuário"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //salvar
                formKey.currentState!.save();

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
              DropdownButton<String>(
                value: userTypeId,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    userTypeId = newValue!;
                  });
                },
                items: <String>['um', 'doiss']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      drawer: const CustomDrawer(),
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
