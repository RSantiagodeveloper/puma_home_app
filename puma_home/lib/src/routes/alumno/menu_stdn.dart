/*
* Pantalla que crea dos botones. Uno para ver los grupos a los que esta inscrito y otro para ver su perfirl.
*/
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

//Widget que crea el boton de ver grupos.
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
              MaterialPageRoute(builder: (context) => MisGruposStdn(idUserState)),
            );
          },
        ));
  }
//Widget que crea boton de ver perfil.
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
    return WillPopScope(
      onWillPop: ()async => false,
          child: Scaffold(
        drawer: MenuAppStdn(idUserState),
        appBar: AppBar(
          backgroundColor: Color(Elementos.contenedor),
          title: Text('Administración (Alumno)',
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
      ),
    );
  }


}
