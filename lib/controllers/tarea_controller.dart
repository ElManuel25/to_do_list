import 'package:to_do_list/controllers/tarea_provider.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/tarea.dart';

void saveTarea(GlobalKey<FormState> _key, Tarea tarea, TareaProvider provider) {
  if (_key.currentState!.validate()) {
    if (provider.tareas.contains(tarea)) {
      provider.updateTarea(tarea);
    } else {
      provider.addTarea(tarea);
    }
  }
}

void deleteTarea(GlobalKey<FormState> _key, Tarea tarea, TareaProvider provider){
  provider.deleteTarea(tarea);
}

void updateTareaCompleta(GlobalKey<FormState> _key, Tarea tarea, TareaProvider provider, bool value){
  provider.updateTareaCompleta(tarea, value);
}

String? validateField(value) {
  return value == null || value!.isEmpty ? "Este campo es obligatorio" : null;
}