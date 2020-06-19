import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/alumno/pantalla_Grupo_stdn.dart';
import 'package:puma_home/src/resources/App_Elements.dart';

class MaterialApoyo extends StatefulWidget {
  final String idUser;
  MaterialApoyo(this.idUser);
  MaterialApoyoState createState() {
    return MaterialApoyoState(idUser);
  }
}


class MaterialApoyoState extends State<MaterialApoyo> {
  String idUserState;
  MaterialApoyoState(this.idUserState);

  Widget createMenuButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 6.67,
      decoration: BoxDecoration(
          color: Color(Elementos.contenedor),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 5, color: Color(Elementos.bordes))),
      child: FlatButton(
          child: Text(
            'Pantalla Grupo',
             style: TextStyle(color: Colors.white),
            ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PantallaGrupoS('userX', 'grpY', '','')));
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppStdn(idUserState),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Material de apoyo', 
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
              createMenuButton(context),
            ],
          )),
    );
  }
}
 