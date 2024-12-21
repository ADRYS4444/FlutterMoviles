import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class EscribirScreen extends StatelessWidget {
  const EscribirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: formulario(),
    );
  }
}

Widget formulario(){
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
      FilledButton(onPressed: ()=>escribir(cedula.text, nombre.text, ciudad.text), child: Text("GUARDAR", style: TextStyle(fontSize: 25),))
    ],
  );
}

Future<void> escribir( cedula, nombre, ciudad) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/"+cedula);

  await ref.set({
    "nombre": nombre,
    "ciudad": ciudad,
  });
}


