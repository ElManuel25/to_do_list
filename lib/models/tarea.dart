class Tarea {
  late String id;
  late String tareaTitle;
  late String tareaTexto;
  late bool estaCompleta;

  Tarea({
    required this.id,
    required this.tareaTitle,
    required this.tareaTexto,
    this.estaCompleta = false,
  });

  // Método para obtener el ID de la tarea
  String getId() {
    return id;
  }


  Tarea.empty() {
    tareaTitle = "";
    tareaTexto = "";
    estaCompleta = false;
  }

  
}
