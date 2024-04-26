class Profesor {
  String nProfesor;
  String nombre;
  String carrera;

  Profesor({
  required this.nProfesor, 
  required this.nombre, 
  required this.carrera});

  Map<String, dynamic> toJson() {
    return {
      'nProfesor': nProfesor,
      'nombre': nombre,
      'carrera': carrera,
    };
  }
}