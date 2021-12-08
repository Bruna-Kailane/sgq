import 'package:flutter/material.dart';
import 'package:sgq/pages/autenticacao.dart';
import 'package:sgq/pages/home_adm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        HomeAdm.routeName: (ctx) => HomeAdm(),
      },
    );
  }
}
