import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:puma_home/src/routes/profesor/crea_tareas.dart';


class VistaTarea extends StatefulWidget{
  final String idUser;
  final String idTarea;
  VistaTarea(this.idUser, this.idTarea);
  @override
  _VistaTareaState createState()=> _VistaTareaState(idUser, idTarea);
}

class _VistaTareaState extends State <VistaTarea>{
  String idUser;
  String idTarea;
  _VistaTareaState(this.idUser, this.idTarea);

  TextEditingController comentarioProf = new TextEditingController();
  TextEditingController calificacion = new TextEditingController();
  GlobalKey<FormState> keyFormulario = new GlobalKey();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Calificar Tarea'),
        centerTitle: true,
        actions: [
            IconButton(
                icon: IconAppBar(), //metodo donde se crea la referencia al icono
                onPressed: null)
          ],
          ),
      drawer: MenuAppTch(idUser),
      body:FutureBuilder(
        future: Firestore.instance.collection('Tareas').document(idTarea).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if(snapshot.hasData){
            Map<String, dynamic> datos = snapshot.data.data;
            comentarioProf.text = datos['Comentario'];
            calificacion.text = datos['Calificacion'];
            return ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.assessment),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('El Alumno Comentó', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/1.1765,
                      height: MediaQuery.of(context).size.height/4,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(Elementos.bordes),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      
                      child: (datos["Comentario_Alumno"] != '')?Text('${datos["Comentario_Alumno"]}'):Text('No Hay Comentario del Alumno'),
                    ),
                  ],
                ),
                Form(
                  key: keyFormulario,
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.1765,
                          height: MediaQuery.of(context).size.height/4,
                          child: TextFormField(
                            controller: comentarioProf,
                            
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/5,
                          height: MediaQuery.of(context).size.height/10,
                          child: TextFormField(
                            controller: calificacion,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Rellenar campo obligatorio';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            side: BorderSide(
                              color: Color(Elementos.bordes),
                              width: 3,
                            )
                          ),
                          color: Color(Elementos.contenedor),
                          onPressed: (){
                            if(keyFormulario.currentState.validate()){
                              Firestore.instance.collection('Tareas').document(idTarea).updateData({
                                'Comentario': comentarioProf.text,
                                'Calificacion': calificacion.text,
                                'Calificado': 1,
                              }).then((value){
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text(
                            'Enviar',
                          ),
                        )
                      ],
                    )
                  ],),
                ),
              ],
            );
          }else{
            return Center(child: Text('Cargando...'),);
          }

        }
      )

    );
}
}

