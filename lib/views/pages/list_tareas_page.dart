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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pagina de crear contacto
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTareaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
    // Text("CREAR UNA LISTA DENTRO DE UN SCAFFOLD");
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
          color: Color.fromARGB(255, 237, 245, 13),
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
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => deleteTarea(_key, tarea, provider),
          ),
        ),
      ),
    );
  }
}
