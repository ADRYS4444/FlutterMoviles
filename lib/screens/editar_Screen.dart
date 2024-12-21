import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditarScreen extends StatelessWidget {
  const EditarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          editarUsuario(),
          Divider(),
          eliminarUsuario(context),
          Divider(),
        ],
      ),
    );
  }
}

Widget editarUsuario(){
  TextEditingController cedula = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController ciudad = TextEditingController();

  return Column(
    children: [
      TextField(
        keyboardType: TextInputType.numberWithOptions(),
        controller: cedula,
        decoration: InputDecoration(
          label: Text("Cedula"),
          border: OutlineInputBorder()
        ),
      ),

      TextField(
        controller: nombre,
        decoration: InputDecoration(
          label: Text("Nombre"),
          border: OutlineInputBorder()
        ),
      ),

      TextField(
        controller: ciudad,
        decoration: InputDecoration(
          label: Text("Ciudad"),
          border: OutlineInputBorder()
        ),
      ),
      FilledButton(onPressed: ()=>editar(cedula.text, nombre.text, ciudad.text), child: Text("EDITAR", style: TextStyle(fontSize: 25),))
    ],
  );
}

Future<void> editar( cedula, nombre, ciudad) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/"+cedula);

  await ref.update({
    "nombre": nombre,
    "ciudad": ciudad,
  });
}

Widget eliminarUsuario(context){
  TextEditingController _cedula = TextEditingController();
  
  return Column(
    children: [
      TextField(
        controller: _cedula,
        decoration: InputDecoration(
          label: Text("Ingresar Cedula"),
          border: OutlineInputBorder()
        ),
      ),
      IconButton(onPressed: ()=>alertaEliminar(context, _cedula.text), icon: Icon(Icons.delete_forever_rounded)),
    ],
  );
  
}

void alertaEliminar(BuildContext context, cedula){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text("¿Estas Seguro de Eliminar Este Usuario?"),
      content: Text("El Usuario se Eliminara Permanentemente!!"),
      actions: [
        IconButton(onPressed: ()=>eliminar(cedula), icon: Icon(Icons.remove_circle_outline)),
        TextButton(onPressed: ()=>Navigator.of(context).pop, child: Text("CANCELAR"))
      ],
    );
  });
  }

Future<void> eliminar( cedula) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/"+cedula);

  await ref.remove();
}

