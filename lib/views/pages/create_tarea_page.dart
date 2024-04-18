import 'package:flutter/material.dart';
import 'package:to_do_list/controllers/tarea_controller.dart';
import 'package:to_do_list/models/tarea.dart';

// ignore: must_be_immutable
class CreateTareaPage extends StatelessWidget {
  String title = "Crear tarea";
  final GlobalKey<FormState> _key = GlobalKey();

  Tarea tarea;
  TaskController _controller = TaskController();

  CreateTareaPage.create() : tarea = Tarea.empty();

  CreateTareaPage.edit(this.tarea);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: formContact(context),
    );
  }

  Form formContact(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: formElements(context),
      ),
    );
  }

  ListView formElements(BuildContext context) {
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
              initialValue: tarea.tareaTitle,
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
              initialValue: tarea.tareaTexto,
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
                createButton(
                  context,
                  Colors.red,
                  "Cancelar",
                  () => Navigator.pop(context),
                ),
                const SizedBox(width: 16),
                createButton(
                  context,
                  Colors.lightBlue,
                  "Guardar",
                  () {
                    saveTarea(_key, tarea);
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  ElevatedButton createButton(
      BuildContext context, Color color, String texto, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
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

  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  void saveTarea(GlobalKey<FormState> key, Tarea tarea) {
  if (key.currentState!.validate()) {
    Map<String, dynamic> tareaMap = {
      'tareaTitle': tarea.tareaTitle,
      'tareaTexto': tarea.tareaTexto,
      'estaCompleta': tarea.estaCompleta,
    };

    _controller.create(tareaMap).then((taskId) {
      tarea.id = taskId; // Almacena el ID generado por Firestore en el objeto Tarea
    }).catchError((error) {
      print("Error al guardar la tarea: $error");
    });
  }
}
}
