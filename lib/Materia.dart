class Materia {
  String nMat;
  String descripcion;

  Materia({
   required this.nMat,
   required this.descripcion});

  Map<String, dynamic> toJson() {
    return {
      'nMat': nMat,
      'descripcion': descripcion,
    };
  }
}
