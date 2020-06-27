/*
 * Pantalla que muestra los detalles del grupo. Consiste en el tablon de anuncios, un boton para ver las tareas, un boton para ver el material de apoyo 
 * y un boton para ver el perfil del profesor. 
 */
import 'package:flutter/material.dart';
import 'package:puma_home/src/routes/alumno/lista_Tareas.dart';
import 'package:puma_home/src/routes/alumno/tablon_stdn.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/alumno/material_Apoyo_stdn.dart';
import 'package:puma_home/src/resources/MenuApp_stdn.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:puma_home/src/routes/alumno/vista_perfil_profesor.dart';

//
class PantallaGrupoS extends StatelessWidget {
  final String idUser; //id del usuario actual
  final String idProfe;
  final String idGroup; //id del Grupo Actual
  final String nombreGrupo;
  PantallaGrupoS(this.idUser, this.idGroup, this.idProfe, this.nombreGrupo);

  Widget createTareasButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 10,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(
                width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text(Elementos.btnTareas),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TareasStdn(idUser, idGroup)),
            );
          },
        ));
  }

  Widget createMaterialButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 10,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(
                width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text(Elementos.btnStorage),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MaterialApoyoStdn(idUser, idGroup)),
            );
          },
        ));
  }

  Widget createPerfilProfesor(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 10,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(
                width: Elementos.widthBorder, color: Color(Elementos.bordes)),
            borderRadius: BorderRadius.circular(20),
            color: Color(Elementos.contenedor)),
        child: FlatButton(
          textColor: Colors.white,
          child: Text('Perfil del Profesor'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VistaPerfil(idUser, idProfe)),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    print(idProfe);
    return Scaffold(
      drawer: MenuAppStdn(idUser),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title:
            Text(nombreGrupo, style: TextStyle(color: Color(Elementos.bordes))),
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
              TablonAnunciosStdn(idGroup),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  createTareasButton(context),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  createMaterialButton(context),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  createPerfilProfesor(context),
                ],
              ),
            ],
          )),
    );
  }
}
