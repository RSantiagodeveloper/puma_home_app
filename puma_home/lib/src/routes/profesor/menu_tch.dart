import 'package:flutter/material.dart';
import 'package:puma_home/src/routes/profesor/mis_Grupos_tch.dart';
import 'package:puma_home/src/routes/profesor/MiPerfil.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

class MenuTch extends StatefulWidget {
  final String idUser;
  MenuTch(this.idUser);
  MenuTchState createState() {
    return MenuTchState(idUser);
  }
}


class MenuTchState extends State<MenuTch> {
  String idUserState;
  MenuTchState(this.idUserState);
  
  Widget createVerGruposButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text(Elementos.btnMiGrp),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MisGruposTch(idUserState)),
            );
          },
        ));
  }

  Widget createMiPerfilButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6.67,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text(Elementos.btnMiPerf),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormMiPerfil(idUserState)),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Admistración (EL MASTER)',
            style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              Divider(),
              createVerGruposButton(context),
              Divider(),
              createMiPerfilButton(context),
            ],
          )),
    );
  }
}
