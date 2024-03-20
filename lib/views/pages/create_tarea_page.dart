import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list/controllers/tarea_provider.dart';
import 'package:to_do_list/controllers/tarea_controller.dart';
import 'package:to_do_list/models/tarea.dart';

class CreateTareaPage extends StatelessWidget {
  // Atributos
  String title = "Crear tarea";
  final GlobalKey<FormState> _key = GlobalKey();

  Tarea tarea = Tarea.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<TareaProvider>(
        builder: (_, tareaProvider, child) {
          return formContact(tareaProvider);
        },
      ),
    );
  }

  Form formContact(TareaProvider provider) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Título de la Tarea",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              onChanged: (value) => tarea.tareaTitle = value,
              validator: validateField,
              decoration: InputDecoration(
                hintText: "Ingrese el título de la tarea",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Descripción de la Tarea",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              maxLines: 8,
              onChanged: (value) => tarea.tareaTexto = value,
              validator: validateField,
              decoration: InputDecoration(
                hintText: "Aquí va la descripción de la tarea",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
              onPressed: () => saveTarea(_key, tarea, provider),
              child: const Text("Guardar"),
            ),
            ),
          ],
        ),
      ),
    );
  }

}