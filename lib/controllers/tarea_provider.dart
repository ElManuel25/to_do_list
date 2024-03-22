import 'package:flutter/foundation.dart';
import 'package:to_do_list/models/tarea.dart';

class TareaProvider extends ChangeNotifier {
  // Lista privada
  final List<Tarea> _tareas = [
    Tarea(
      tareaTitle: 'Hacer la app de Tareas',
      tareaTexto:
          'Terminar la app de tareas antes del viernes 22 de marzo a las 23:59',
      estaCompleta: true,
    ),
    Tarea(
      tareaTitle: 'Comprar leche',
      tareaTexto: 'Ir al supermercado y comprar dos litros de leche',
      estaCompleta: false,
    ),
    Tarea(
      tareaTitle: 'Pagar la factura del teléfono',
      tareaTexto:
          'Ingresar al portal web del proveedor y pagar la factura pendiente',
      estaCompleta: false,
    ),
    Tarea(
      tareaTitle: 'Subir la tarea a Uvirtual',
      tareaTexto: 'No olvidarme de subir el link del repositorio a Uvirtual',
      estaCompleta: false,
    ),
    Tarea(
      tareaTitle: 'Hacer ejercicio',
      tareaTexto: 'Ir al gimnasio y hacer una sesión de ejercicios de 1 hora',
      estaCompleta: true,
    ),
  ];

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

  void updateTarea(Tarea tareaActualizada) {
    // Buscar la tarea existente en la lista por su referencia
    int index = _tareas.indexWhere((tarea) => tarea == tareaActualizada);
    if (index != -1) {
      _tareas[index] = tareaActualizada;
      notifyListeners();
    }
  }
}
