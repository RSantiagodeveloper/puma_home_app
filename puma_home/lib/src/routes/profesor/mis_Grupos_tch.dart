import 'package:flutter/material.dart';
import 'package:puma_home/src/resources/MenuApp_tch.dart';
import 'package:puma_home/src/routes/profesor/pantalla_Grupo_tch.dart';
import 'package:puma_home/src/resources/App_Elements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puma_home/src/routes/profesor/formulario_alta_clases.dart';
import 'package:puma_home/model/tchgrupos.dart';
import 'package:puma_home/src/resources/iconAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MisGruposTch extends StatefulWidget {
  @override
  _MisGruposState createState() => _MisGruposState();
}
/// widget que devuelve una tarjeta. Esta contiene la informacion de un grupo
/// parametro nombre recibe el nombre de la clase
/*
class ListaGrupos extends StatefulWidget{
  @override
  _ListaGruposEstado createState() => _ListaGruposEstado();
}

final referenciaGrupo = FirebaseDatabase.instance.reference().child('Grupo');

class _ListaGruposEstado extends State<ListaGrupos>{
  List<Grupo> items;
  StreamSubscription<Event> _onGrupoAddedSub;
  StreamSubscription<Event> _onGrupoChangedSub;

  @override
  void initState(){
    super.initState();
    items = List();
    _onGrupoAddedSub = referenciaGrupo.onChildAdded.listen(_onGrupoAdded);
    _onGrupoChangedSub = referenciaGrupo.onChildChanged.listen(_onGrupoUpdate);
    
  }

  @override
  void dispose() {
    super.dispose();
    _onGrupoAddedSub.cancel();
    _onGrupoChangedSub.cancel();
  }

  void _onGrupoAdded(Event event) {
    setstate(() {
      items.add(Grupo.fromSnapShot(event.snapshot));
    });
  }

  void _onGrupoUpdate(Event event) {
    grupoAnterior = items.singleWhere((Grupo) => Grupo.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(grupoAnterior)] = Grupo.fromSnapShot(event.snapshot);
    });
  }
}
*/
Widget grupo(BuildContext context, DocumentSnapshot ds) {
  return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.album),
              title: Text(ds['Nombre']),
              subtitle: Text('Clave'),
            ),   
          InkWell(
            splashColor: Color(Elementos.contenedor),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(
                          builder: (context) =>
                              PantallaGrupoTch('userX', 'grpY')));
            },
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: 
                  //Icon(Icons.delete),
                  Text('Borrar'),
                onPressed: () {/*borrar*/},
              ),
            ],
          ),
        ],
      ));
}

class _MisGruposState extends State<MisGruposTch>  {

  List<TchGrupos> grupos;
  ///referencia a la base de datos de firebase
  final _auth = FirebaseAuth.instance;
  FirebaseUser usuario;

  void getReferenceUsr() async{
    final resp = await _auth.currentUser();
    usuario = resp;
  }
  
  void initState(){
    super.initState();
    getReferenceUsr();
  }

  /* Future<void> listGrup(String iduser) async {
    Map<String, dynamic> valor;
    var data = await fireReference.collection('Mis').where("idteacher",isEqualTo:iduser).getDocuments().then((value){
      value.documents.forEach((result){
            valor = result.data;
             grupos.add(valor['NombreClase']);
       });
    });
  } */
  /* TODO: arreglar el delete
  Future<void> DelateGroup(String iduser, String nombreMat) async {
    var erase = await fireReference.collection('MisGrupos').where("idteacher",isEqualTo:iduser).where("nombreClase",isEqualTo:nombreMat).delete();
  }
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuAppTch(),
      appBar: AppBar(
        backgroundColor: Color(Elementos.contenedor),
        title: Text('Mis Grupos', 
        style: TextStyle(color: Color(Elementos.bordes))),
        centerTitle: true,
        actions: [
          IconButton(
              icon: IconAppBar(), //metodo donde se crea la referencia al icono
              onPressed: null)
        ],
      ),
      body: StreamBuilder(

          stream: Firestore.instance.collection('Grupo').where('Id_profesor', isEqualTo: usuario.uid).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Text('No hay datos');
            }else{
              //<DocumentSnapshot> datos = snapshot.data.documents;
              
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index){
                  return grupo(context, snapshot.data.documents[index]);
                }
              );
            }
          }
          
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {   
         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FormularioAltaClase())); //aqui va la llamada a la pantalla formulario_alta_clases
        },
        backgroundColor: Color(Elementos.contenedor),
        child: Icon(Icons.add),
      ),
    );
  }
}


///ricardo
///hanibal
///angel
///espejel
///todos ellos en esta pantalla
///
///
///
///
/*Widget _grupo(BuildContext context, String nombre) {
  return Card(
      margin: EdgeInsets.all(10.0), 
      color: Color(Elementos.contenedor),
      child: Column(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.class_),
            title: Text('Clase '),
            //subtitle: Text('Profesor ')
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('Detalles'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PantallaGrupoTch('userX', 'grpY')));
                  }
                ),
                FlatButton(
                  child: 
                    //Icon(Icons.delete),
                    Text('Borrar'),
                onPressed: () {/*borrar*/},
              ),
            ],
          ),
        ],
      ));
}
*/