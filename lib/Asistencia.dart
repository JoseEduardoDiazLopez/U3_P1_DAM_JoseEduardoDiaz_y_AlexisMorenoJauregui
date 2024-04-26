class Asistencia {
  int idAsistencia;
  int nHorario;
  String fecha;
  bool asistencia;

  Asistencia({
    required this.idAsistencia,
    required this.nHorario,
    required this.fecha,
    required this.asistencia,
  });

  Map<String, dynamic> toJson() {
    return {
      'idAsistencia': idAsistencia,
      'nHorario': nHorario,
      'fecha': fecha,
      'asistencia': asistencia,
    };
  }

  Map<String, dynamic> toJsonExcludingId() {
    return {
      'nHorario': nHorario,
      'fecha': fecha,
      'asistencia': asistencia,
    };
  }
}
