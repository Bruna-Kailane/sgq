import 'package:flutter/material.dart';

class HomeAdm extends StatefulWidget {
  static const String routeName = "/";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeAdm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SGQ"),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
