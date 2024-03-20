import 'package:to_do_list/controllers/tarea_provider.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/tarea.dart';

void saveTarea(
    GlobalKey<FormState> _key, Tarea tarea, TareaProvider provider) {
  // Valido el formulario
  if (_key.currentState!.validate()) {
    // Agregar a la lista del provider
    provider.addTarea(tarea);
  }
}

void deleteTarea(GlobalKey<FormState> _key, Tarea tarea, TareaProvider provider){
  provider.deleteTarea(tarea);
}

String? validateField(value) {
  return value == null || value!.isEmpty ? "Este campo es obligatorio" : null;
}