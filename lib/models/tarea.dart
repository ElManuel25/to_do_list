class Tarea {
  late String tareaTitle;
  late String tareaTexto;
  late bool estaCompleta;

  Tarea({
    required this.tareaTitle,
    required this.tareaTexto,
    this.estaCompleta = false
  });

  Tarea.empty() {
    tareaTitle = "";
    tareaTexto = "";
  }
}