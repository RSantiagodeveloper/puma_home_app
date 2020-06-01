import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/routes/alumno/MiPerfil_stdn.dart';
import 'package:puma_home/src/routes/alumno/mis_grupos_stdn.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

class MenuAlumno extends StatefulWidget {
  final String idUser;
  MenuAlumno(this.idUser);
  MenuAlumnoState createState() {
    return MenuAlumnoState(idUser);
  }
}


class MenuAlumnoState extends State<MenuAlumno> {
  String idUserState;
  MenuAlumnoState(this.idUserState);

  void initState(){
    super.initState();
    print('$idUserState');
  }

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
              MaterialPageRoute(builder: (context) => MisGruposStdn(idUserState)), //TODO: pasarle el id de usuario
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
      drawer: MenuAppStdn(),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Administración (LOS MORROS)',
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
