import 'dart:ffi';

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
          return formContact(tareaProvider, context);
        },
      ),
    );
  }

  Form formContact(TareaProvider provider, BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: formElements(provider, context)),
    );
  }

  ListView formElements(TareaProvider provider, BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Título de la Tarea",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              onChanged: (value) => tarea.tareaTitle = value,
              validator: validateField,
              decoration: const InputDecoration(
                hintText: "Ingrese el título de la tarea",
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Descripción de la Tarea",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 8,
              onChanged: (value) => tarea.tareaTexto = value,
              validator: validateField,
              decoration: const InputDecoration(
                hintText: "Aquí va la descripción de la tarea",
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createButton(context, Colors.red, "Cancelar", provider, false),
                const SizedBox(width: 16),
                createButton(
                    context, Colors.lightBlue, "Guardar", provider, true)
              ],
            )
          ],
        ),
      ],
    );
  }

  ElevatedButton createButton(
      BuildContext context, Color color, String texto, provider, bool bool) {
    return ElevatedButton(
      onPressed: () {
        if (bool == true) {
          saveTarea(_key, tarea, provider);
        }
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
