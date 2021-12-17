import 'package:flutter/material.dart';
import 'package:sgq/widget/custom_drawer.dart';

class HomeAdm extends StatefulWidget {
  static const String routeName = "/";

  const HomeAdm({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeAdm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SGQ"),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
