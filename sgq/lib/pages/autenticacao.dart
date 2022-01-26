import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/services/autenticacao_servico.dart';

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

  submeter(AutenticacaoServico autenticacaoServico) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        processando = true;
        erro = '';
      });
      try {
        await autenticacaoServico.signIn(email, senha);
      } on Exception catch (e) {
        setState(() {
          erro = e.toString();
        });
      }
      setState(() {
        processando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final autenticacaoServ =
        Provider.of<AutenticacaoServico>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: <Widget>[
            Image.asset('assets/imagem/sport.jpg', fit: BoxFit.cover),
            const Positioned(
              top: 140,
              left: 32,
              child: Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                padding: const EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(52),
                    topRight: Radius.circular(52),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.people_alt_rounded,
                        color: Colors.green,
                        size: 80,
                      ),
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
                          icon: Icon(ocultarSenha
                              ? Icons.visibility
                              : Icons.visibility_off),
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
                                SizedBox(
                                  width: 250,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30)))),
                                    onPressed: () {
                                      submeter(autenticacaoServ);
                                    },
                                    child: const Text(
                                      "Entrar",
                                      style: TextStyle(
                                          fontSize: 32, color: Colors.white),
                                    ),
                                  ),
                                )
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
            )
          ],
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
        //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
