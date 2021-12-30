import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/autenticacao.dart';
import 'package:sgq/pages/home_adm.dart';
import 'package:sgq/services/autenticacao_servico.dart';

class Splash extends StatelessWidget {
  static const routeName = '/splash';

  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final autenticacaoServ = Provider.of<AutenticacaoServico>(context);

    return autenticacaoServ.logado ? HomeAdm() : const Autenticacao();
  }
}
