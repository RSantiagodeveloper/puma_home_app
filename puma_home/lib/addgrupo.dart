import 'package:flutter/material.dart';
final _formKey = GlobalKey<FormState>();

class Addgrupo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Title(
          color: Colors.blue,
          child: Text("Añade un grupo nuevo"),
        ),
      ),
      drawer: new Drawer(),
      body: ListView(
                  padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: <Widget>[
            _introducirTexto(),
          ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            // AQUI ENTRA LA LOGICA DE VALIDACION DE DATOS DE LOS CAMPOS
            //CUalquier consulta a Bases se coloca aqui
          }
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

Widget _introducirTexto() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'clave del grupo',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'campo obligatorio'; //NOTA PARA EQUIPO BACKEND: Pongan condicional evitar mandar caracteres especiales
                //  y que la base de datos no se la lleve la verga
              }
              return null;
            },
          ),
        ],
      ),
    ),
  );
}
