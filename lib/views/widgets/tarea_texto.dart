import 'package:flutter/material.dart';
import 'package:to_do_list/models/tarea.dart';

Widget tareaText(Tarea tarea) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Text(
      tarea.tareaTexto
    ),
  );
}