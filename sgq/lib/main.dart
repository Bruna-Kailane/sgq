import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/autenticacao.dart';
import 'package:sgq/pages/cadastro_area.dart';
import 'package:sgq/pages/cadastro_reserva.dart';
import 'package:sgq/pages/cadastro_type_user.dart';
import 'package:sgq/pages/cadastro_user.dart';
import 'package:sgq/pages/descricao_reserva.dart';
import 'package:sgq/pages/home.dart';
import 'package:sgq/pages/lista_area.dart';
import 'package:sgq/pages/lista_type_user.dart';
import 'package:sgq/pages/lista_users.dart';
import 'package:sgq/pages/minhas_reservas.dart';
import 'package:sgq/pages/pedido_reserva.dart';
import 'package:sgq/pages/splash.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_tipo_user.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/services/autenticacao_servico.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AutenticacaoServico()),
          ChangeNotifierProxyProvider<AutenticacaoServico,
              RepositorioEducationArea>(
            create: (ctx) => RepositorioEducationArea(
                Provider.of<AutenticacaoServico>(ctx, listen: false)),
            update: (ctx, autenticacaoServ, anterior) =>
                RepositorioEducationArea(autenticacaoServ),
          ),
          ChangeNotifierProxyProvider<AutenticacaoServico, RepositorioTipoUser>(
            create: (ctx) => RepositorioTipoUser(
                Provider.of<AutenticacaoServico>(ctx, listen: false)),
            update: (ctx, autenticacaoServ, anterior) =>
                RepositorioTipoUser(autenticacaoServ),
          ),
          ChangeNotifierProxyProvider<AutenticacaoServico, RepositorioUsers>(
            create: (ctx) => RepositorioUsers(
                Provider.of<AutenticacaoServico>(ctx, listen: false)),
            update: (ctx, autenticacaoServ, anterior) =>
                RepositorioUsers(autenticacaoServ),
          ),
          ChangeNotifierProxyProvider<AutenticacaoServico, RepositorioReserve>(
            create: (ctx) => RepositorioReserve(
                Provider.of<AutenticacaoServico>(ctx, listen: false)),
            update: (ctx, autenticacaoServ, anterior) =>
                RepositorioReserve(autenticacaoServ),
          ),
        ],
        builder: (ctx, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SGQ',
            theme: ThemeData(
              primaryColor: Colors.green[900],
              colorScheme: ColorScheme.light(
                primary: Colors.green.shade900,
                secondary: Colors.red.shade900,
              ),
            ),
            initialRoute: Splash.routeName,
            routes: {
              Splash.routeName: (ctx) => const Splash(),
              Autenticacao.routeName: (ctx) => const Autenticacao(),
              Home.routeName: (ctx) => const Home(),
              CadastroArea.routeName: (ctx) => CadastroArea(),
              CadastroTypeUser.routeName: (ctx) => CadastroTypeUser(),
              CadastroUser.routeName: (ctx) => const CadastroUser(),
              CadastroReserva.routeName: (ctx) => const CadastroReserva(),
              ListaArea.routeName: (ctx) => const ListaArea(),
              ListaTypeUser.routeName: (ctx) => const ListaTypeUser(),
              ListaUsers.routeName: (ctx) => const ListaUsers(),
              PedidoReserva.routename: (ctx) => const PedidoReserva(),
              DescricaoReserva.routeName: (ctx) => const DescricaoReserva(),
              MinhasReservas.routename: (ctx) => const MinhasReservas(),
            },
          );
        });
  }
}
