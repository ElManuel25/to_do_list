import 'package:to_do_list/controllers/tarea_controller.dart';
import 'package:to_do_list/controllers/tarea_provider.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/tarea.dart';
import 'package:to_do_list/views/pages/create_tarea_page.dart';
import 'package:provider/provider.dart';

class ListTareasPage extends StatelessWidget {
  String title = "Lista de tareas";
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<TareaProvider>(
        builder: (_, tareaProvider, child) {
          return getListView(tareaProvider);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(20, 34, 103, 0.765),
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
                      builder: (context) => CreateTareaPage(),
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

  Widget getListView(TareaProvider provider) {
    // Lista de contactos
    List<Tarea> tareas = provider.tareas;
    return Padding(
      padding: const EdgeInsets.all(10),
      // Lista de los widgets de los contactos
      child: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (_, index) {
          Tarea tarea = tareas[index];
          // Retornar el widget de cada contacto
          return tareaWidget(tarea, provider);
        },
      ),
    );
  }

  Widget tareaWidget(Tarea tarea, TareaProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(188, 237, 245, 13),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
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
                checkColor: Colors.white, // Color del marcador
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors
                        .blue; // Color de relleno cuando está seleccionado
                  }
                  return Colors
                      .grey; // Color de relleno cuando no está seleccionado
                }),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => deleteTarea(_key, tarea, provider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
