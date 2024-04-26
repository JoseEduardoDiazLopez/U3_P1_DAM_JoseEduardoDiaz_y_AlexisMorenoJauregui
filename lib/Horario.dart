class Horario {
  int? nHorario;
  String nProfesor;
  String nMat;
  String hora;
  String edificio;
  String salon;

  Horario({
    this.nHorario,
    required this.nProfesor,
    required this.nMat,
    required this.hora,
    required this.edificio,
    required this.salon,
  });

  Map<String, dynamic> toJson() {
    return {
      'nHorario': nHorario,
      'nProfesor': nProfesor,
      'nMat': nMat,
      'hora': hora,
      'edificio': edificio,
      'salon': salon,
    };
  }
  Map<String, dynamic> toJsonExcludingId() {
  return {
    'nProfesor': this.nProfesor,
    'nMat': this.nMat,
    'hora': this.hora,
    'edificio': this.edificio,
    'salon': this.salon,
  };
}
}