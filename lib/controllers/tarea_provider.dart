import 'package:flutter/foundation.dart';
import 'package:to_do_list/models/tarea.dart';

class TareaProvider extends ChangeNotifier {
  // Lista privada
  List<Tarea> _tareas = [];

// Lista pública
  List<Tarea> get tareas => _tareas;

  addTarea(Tarea tarea) {
    _tareas.add(tarea);
    // Notificar a los suscriptores de que hay un cambio
    notifyListeners();
  }

  deleteTarea(Tarea tarea) {
    _tareas.remove(tarea);
    notifyListeners();
  }

  updateTareaCompleta(Tarea tarea, bool newValue) {
    tarea.estaCompleta = newValue;
    notifyListeners();
  }
}
