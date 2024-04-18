import 'package:flutter/material.dart';
import 'package:to_do_list/controllers/tarea_controller.dart';
import 'package:to_do_list/models/tarea.dart';
import 'package:to_do_list/views/pages/create_tarea_page.dart';

class ListTareasPage extends StatefulWidget {
  @override
  _ListTareasPageState createState() => _ListTareasPageState();
}

class _ListTareasPageState extends State<ListTareasPage> {
  String title = "Lista de tareas";
  Color appbarsColor = const Color.fromRGBO(20, 34, 103, 0.765);
  final GlobalKey<FormState> key = GlobalKey();
  String filtroSeleccionado = 'Todas'; 
  TaskController _taskController = TaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: appbarsColor,
        actions: [
          dropDownFiltro(),
          const SizedBox(width: 16), // Espaciado entre el DropdownButton y el título
        ],
      ),
      body: FutureBuilder<List<Tarea>>(
        future: _taskController.getTareas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Tarea> tareas = snapshot.data!;
            return getListView(tareas);
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: appbarsColor,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Agregar tarea',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              IconButton(
                onPressed: () {
                  // Navegar a la página de crear tarea
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateTareaPage.create(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> dropDownFiltro() {
    return DropdownButton<String>(
      value: filtroSeleccionado,
      onChanged: (String? newValue) {
        setState(() {
          filtroSeleccionado = newValue!;
        });
      },
      items: <String>['Todas', 'Completadas', 'Sin completar']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black, 
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget getListView(List<Tarea> tareas) {
    if (filtroSeleccionado == 'Completadas') {
      tareas = tareas.where((tarea) => tarea.estaCompleta).toList();
    } else if (filtroSeleccionado == 'Sin completar') {
      tareas = tareas.where((tarea) => !tarea.estaCompleta).toList();
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (_, index) {
          Tarea tarea = tareas[index];
          return tareaWidget(context, tarea);
        },
      ),
    );
  }

  Widget tareaWidget(BuildContext context, Tarea tarea) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(188, 237, 245, 13),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          tarea.tareaTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          tarea.tareaTexto,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: tarea.estaCompleta,
              onChanged: (newValue) {
                // Lógica para actualizar la tarea completada
              },
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.blue;
                }
                return Colors.grey;
              }),
            ),
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                // Lógica para editar la tarea
              },
            ),
            IconButton(
  icon: const Icon(
    Icons.delete_outline,
    color: Colors.black,
  ),
  onPressed: () {
    confirmarEliminarTarea(context, tarea);
  },)
          ],
        ),
      ),
    ),
  );
}

// Función confirmarEliminarTarea
void confirmarEliminarTarea(BuildContext context, Tarea tarea) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialogConfirmacion(context, tarea);
    },
  );
}

// En la función alertDialogConfirmacion
AlertDialog alertDialogConfirmacion(BuildContext context, Tarea tarea) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: const Text(
      "Confirmación",
      style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
    ),
    content: Text(
      "¿Estás seguro de que quieres eliminar esta tarea?",
      style: const TextStyle(color: Colors.black54),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Cancelar",
          style: TextStyle(color: Colors.red),
        ),
      ),
      TextButton(
        onPressed: () {
          deleteTarea(tarea);
          Navigator.of(context).pop();
        },
        child: const Text(
          "Eliminar",
          style: TextStyle(color: Colors.green),
        ),
      ),
    ],
  );
}

// Y la función deleteTarea en la página ListTareasPage
// En la función deleteTarea
void deleteTarea(Tarea tarea) {
  TaskController _taskController = TaskController();
  _taskController.deleteTarea(tarea.id).then((_) {
    // Tarea eliminada exitosamente
  }).catchError((error) {
    print("Error al eliminar la tarea: $error");
    // Manejar el error según sea necesario
  });
}
}