import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/controllers/tarea_provider.dart';
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
  final GlobalKey<FormState> _key = GlobalKey();
  String filtroSeleccionado = 'Todas'; 

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
      body: Consumer<TareaProvider>(
        builder: (_, tareaProvider, child) {
          return getListView(tareaProvider, context);
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
                  color: Colors
                      .black, 
                ),
              ),
            );
          }).toList(),
        );
  }

  Widget getListView(TareaProvider provider, BuildContext context) {
    List<Tarea> tareas = provider.tareas;

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
          return tareaWidget(context, tarea, provider);
        },
      ),
    );
  }

  Widget tareaWidget(
      BuildContext context, Tarea tarea, TareaProvider provider) {
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
                  updateTareaCompleta(_key, tarea, provider, newValue!);
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
                  // Editar
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateTareaPage.edit(tarea),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.black,
                ),
                onPressed: () =>
                    confirmarEliminarTarea(context, tarea, provider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmarEliminarTarea(
      BuildContext context, Tarea tarea, TareaProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogConfirmacion(tarea, context, provider);
      },
    );
  }

  AlertDialog alertDialogConfirmacion(
      Tarea tarea, BuildContext context, TareaProvider provider) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text(
        "Confirmación",
        style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
      ),
      content: Text(
        tarea.estaCompleta
            ? "Esta tarea ya está completada. ¿Estás seguro de que quieres eliminarla?"
            : "Esta tarea no está completada. ¿Seguro que quieres eliminarla?",
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
            deleteTarea(_key, tarea, provider);
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
}
