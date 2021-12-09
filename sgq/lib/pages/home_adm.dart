import 'package:flutter/material.dart';
import 'package:sgq/pages/cadastro_area.dart';

class HomeAdm extends StatefulWidget {
  static const String routeName = "/";

  const HomeAdm({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeAdm> {
  @override
  Widget build(BuildContext context) {
    novaArea() {
      Navigator.of(context).pushNamed(CadastroArea.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("SGQ"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.list),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: const Text("Novo Usuario"),
                onTap: () {},
              ),
              PopupMenuItem(
                child: const Text("Novo Tipo Usuario"),
                onTap: () {},
              ),
              PopupMenuItem(
                child: const Text("Nova Area"),
                onTap: novaArea(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
