import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/repositories/repositorio_education_area.dart';
import 'package:sgq/repositories/repositorio_tipo_user.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:sgq/widget/custom_drawer.dart';

class HomeAdm extends StatefulWidget {
  static const String routeName = "/";

  const HomeAdm({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeAdm> {
  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<RepositorioEducationArea>(context, listen: false)
          .loadRemote();
      Provider.of<RepositorioTipoUser>(context, listen: false).loadRemote();
      Provider.of<RepositorioUsers>(context, listen: false).loadRemote();
    }
    _init = false;
    super.didChangeDependencies();
  }

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
