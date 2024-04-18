import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/controllers/tarea_provider.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/tarea.dart';

class TaskController{
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = "tasks";

  Future<String> create(Map<String, dynamic> task) async {
    DocumentReference response = await db.collection(collection).add(task);
    return response.id;
  }

  Future<List<Tarea>> getTareas() async {
    try {
      QuerySnapshot querySnapshot = await db.collection(collection).get();
      List<Tarea> tareas = [];
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Tarea tarea = Tarea(
          tareaTitle: data['tareaTitle'],
          tareaTexto: data['tareaTexto'],
          estaCompleta: data['estaCompleta'] ?? false,
        );
        tareas.add(tarea);
      });
      return tareas;
    } catch (error) {
      throw error;
    }
  }
}

void saveTarea(GlobalKey<FormState> _key, Tarea tarea, TareaProvider provider) {
  if (_key.currentState!.validate()) {
    if (provider.tareas.contains(tarea)) {
      provider.updateTarea(tarea);
    } else {
      provider.addTarea(tarea);
    }
  }
}

void deleteTarea(
    GlobalKey<FormState> _key, Tarea tarea, TareaProvider provider) {
  provider.deleteTarea(tarea);
}

void updateTareaCompleta(GlobalKey<FormState> _key, Tarea tarea,
    TareaProvider provider, bool value) {
  provider.updateTareaCompleta(tarea, value);
}

String? validateField(value) {
  return value == null || value!.isEmpty ? "Este campo es obligatorio" : null;
}

