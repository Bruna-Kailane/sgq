import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/pages/autenticacao.dart';
import 'package:sgq/pages/cadastro_area.dart';
import 'package:sgq/pages/cadastro_type_user.dart';
import 'package:sgq/pages/home_adm.dart';
import 'package:sgq/pages/lista_area.dart';
import 'package:sgq/pages/lista_type_user.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/repositories/repositorio_tipo_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => RepositorioEducationArea()),
          ChangeNotifierProvider(create: (ctx) => RepositorioTipoUser()),
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
            initialRoute: HomeAdm.routeName,
            routes: {
              Autenticacao.routeName: (ctx) => const Autenticacao(),
              HomeAdm.routeName: (ctx) => const HomeAdm(),
              CadastroArea.routeName: (ctx) => CadastroArea(),
              CadastroTypeUser.routeName: (ctx) => CadastroTypeUser(),
              ListaArea.routeName: (ctx) => const ListaArea(),
              ListaTypeUser.routeName: (ctx) => const ListaTypeUser(),
            },
          );
        });
  }
}
