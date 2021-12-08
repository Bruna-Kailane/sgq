import 'package:flutter/material.dart';

class Autenticacao extends StatefulWidget {
  static const routeName = '/autenticacao';
  const Autenticacao({Key? key}) : super(key: key);

  @override
  _AutenticacaoState createState() => _AutenticacaoState();
}

class _AutenticacaoState extends State<Autenticacao> {
  var email = '';
  var senha = '';
  var ocultarSenha = true;
  final formKey = GlobalKey<FormState>();
  var processando = false;
  var erro = '';

  mudarOcultarSenha() {
    setState(() {
      ocultarSenha = !ocultarSenha;
    });
  }

  /* submeter(AutenticacaoServico autenticacaoServico) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        processando = true;
        erro = '';
      });
      try {
        if (novoUsuario) {
          await autenticacaoServico.signUp(email, senha);
        } else {
          await autenticacaoServico.signIn(email, senha);
        }
      } on Exception catch (e) {
        setState(() {
          erro = e.toString();
        });
      }
      setState(() {
        processando = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //final autenticacaoServ = Provider.of<AutenticacaoServico>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SGQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Formulario(
                label: "E-mail",
                hint: "Digite seu e-mail",
                icon: const Icon(Icons.email),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Email obrigatorio";
                  }
                  if (!text.contains("@") || !text.contains(".")) {
                    return "Digite um e-mail valido";
                  }
                },
                save: (text) {
                  setState(() {
                    email = text ?? '';
                  });
                },
              ),
              const SizedBox(height: 8),
              _Formulario(
                label: "Senha",
                hint: "Digite sua senha",
                obscureText: ocultarSenha,
                icon: const Icon(Icons.vpn_key),
                sufixIcon: IconButton(
                  icon: Icon(
                      ocultarSenha ? Icons.visibility : Icons.visibility_off),
                  onPressed: mudarOcultarSenha,
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Senha obrigatoria";
                  }
                  if (text.length < 6) {
                    return "A senha precisa ser maior que 6 caracteres";
                  }
                },
                save: (text) {
                  setState(() {
                    senha = text ?? '';
                  });
                },
              ),
              const SizedBox(height: 20),
              processando
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //submeter(autenticacaoServ);
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
              if (erro.isNotEmpty) const SizedBox(height: 50),
              if (erro.isNotEmpty)
                Text(
                  erro,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Formulario extends StatelessWidget {
  final String label;
  final String hint;
  final Icon? icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? save;
  final bool obscureText;
  final Widget? sufixIcon;

  const _Formulario({
    Key? key,
    required this.label,
    required this.hint,
    this.icon,
    this.keyboardType,
    this.validator,
    this.save,
    this.obscureText = false,
    this.sufixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: save,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: sufixIcon,
        prefixIcon: icon,
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
