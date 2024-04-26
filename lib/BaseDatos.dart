import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Materia.dart';
import 'Horario.dart';
import 'Asistencia.dart';
import 'Profesor.dart';
import 'BaseDatos.dart';


class DB {
  static Future<Database> _abrirDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "base4.db"),
      onCreate: (db, version) {
        //LLAMO METODOS PARA CREAR LAS TABLAS
        _crearTablaMateria(db);
        _crearTablaProfesor(db);
        _crearTablaHorario(db);
        _crearTablaAsistencia(db);
      },
      version: 1,
    );
  }

  static Future<void> _crearTablaMateria(Database db) async {
    await db.execute("CREATE TABLE MATERIA (NMAT TEXT PRIMARY KEY, DESCRIPCION TEXT);");
  }//MATERIA

  static Future<void> _crearTablaProfesor(Database db) async {
    await db.execute("CREATE TABLE PROFESOR (NPROFESOR TEXT PRIMARY KEY, NOMBRE TEXT, CARRERA TEXT);");
  }//PROFESOR

  static Future<void> _crearTablaHorario(Database db) async {
    await db.execute("CREATE TABLE HORARIO (NHORARIO INTEGER PRIMARY KEY AUTOINCREMENT, NPROFESOR TEXT,NMAT TEXT, HORA TEXT,EDIFICIO TEXT,SALON TEXT,FOREIGN KEY (NPROFESOR) REFERENCES PROFESOR(NPROFESOR),FOREIGN KEY (NMAT) REFERENCES MATERIA(NMAT));");
  }//HORARIO

  static Future<void> _crearTablaAsistencia(Database db) async {
    await db.execute("CREATE TABLE ASISTENCIA (IDASISTENCIA INTEGER PRIMARY KEY AUTOINCREMENT, NHORARIO INT, FECHA TEXT, ASISTENCIA BOOLEAN, FOREIGN KEY (NHORARIO) REFERENCES HORARIO(NHORARIO));");
  }//ASISTENCIA



 //CRUD MATERIA 
   // Método para insertar una nueva materia en la base de datos
  static Future<void> insertarMateria(Materia materia) async {
    Database db = await _abrirDB();
    await db.insert(
      'MATERIA',
      materia.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await cerrarDB(db);
  }

  // Método para obtener todas las materias de la base de datos
  static Future<List<Materia>> obtenerTodasLasMaterias() async {
    Database db = await _abrirDB();
    final List<Map<String, dynamic>> materiasMap = await db.query('MATERIA');
    await cerrarDB(db);
    return List.generate(materiasMap.length, (i) {
      return Materia(
        nMat: materiasMap[i]['NMAT'],
        descripcion: materiasMap[i]['DESCRIPCION'],
      );
    });
  }

  // Método para actualizar una materia en la base de datos
  static Future<void> actualizarMateria(Materia materia) async {
    Database db = await _abrirDB();
    await db.update(
      'MATERIA',
      materia.toJson(),
      where: "NMAT = ?",
      whereArgs: [materia.nMat],
    );
    await cerrarDB(db);
  }

  // Método para eliminar una materia de la base de datos
  static Future<void> eliminarMateria(String nMat) async {
    Database db = await _abrirDB();
    await db.delete(
      'MATERIA',
      where: "NMAT = ?",
      whereArgs: [nMat],
    );
    await cerrarDB(db);
  }

// CRUD PROFESOR

  // Método para insertar un nuevo profesor en la base de datos
  static Future<void> insertarProfesor(Profesor profesor) async {
    Database db = await _abrirDB();
    await db.insert(
      'PROFESOR',
      profesor.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await cerrarDB(db);
  }

  // Método para obtener todos los profesores de la base de datos
  static Future<List<Profesor>> obtenerTodosLosProfesores() async {
    Database db = await _abrirDB();
    final List<Map<String, dynamic>> profesoresMap = await db.query('PROFESOR');
    await cerrarDB(db);
    return List.generate(profesoresMap.length, (i) {
      return Profesor(
        nProfesor: profesoresMap[i]['NPROFESOR'],
        nombre: profesoresMap[i]['NOMBRE'],
        carrera: profesoresMap[i]['CARRERA'],
      );
    });
  }

  // Método para actualizar un profesor en la base de datos
  static Future<void> actualizarProfesor(Profesor profesor) async {
    Database db = await _abrirDB();
    await db.update(
      'PROFESOR',
      profesor.toJson(),
      where: "NPROFESOR = ?",
      whereArgs: [profesor.nProfesor],
    );
    await cerrarDB(db);
  }

  // Método para eliminar un profesor de la base de datos
  static Future<void> eliminarProfesor(String nProfesor) async {
    Database db = await _abrirDB();
    await db.delete(
      'PROFESOR',
      where: "NPROFESOR = ?",
      whereArgs: [nProfesor],
    );
    await cerrarDB(db);
  }

// Método para insertar una nueva asistencia en la base de datos
  static Future<void> insertarAsistencia(Asistencia asistencia) async {
    Database db = await _abrirDB();
    await db.insert(
      'ASISTENCIA',
      asistencia.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await cerrarDB(db);
  }

  // Método para obtener todas las asistencias de la base de datos
  static Future<List<Asistencia>> obtenerTodasLasAsistencias() async {
    Database db = await _abrirDB();
    final List<Map<String, dynamic>> asistenciasMap = await db.query('ASISTENCIA');
    await cerrarDB(db);
    return List.generate(asistenciasMap.length, (i) {
      return Asistencia(
        idAsistencia: asistenciasMap[i]['IDASISTENCIA'],
        nHorario: asistenciasMap[i]['NHORARIO'],
        fecha: asistenciasMap[i]['FECHA'],
        asistencia: asistenciasMap[i]['ASISTENCIA'] == 1 ? true : false,
      );
    });
  }

  // Método para actualizar una asistencia en la base de datos
  static Future<void> actualizarAsistencia(Asistencia asistencia) async {
    Database db = await _abrirDB();
    await db.update(
      'ASISTENCIA',
      asistencia.toJson(),
      where: "IDASISTENCIA = ?",
      whereArgs: [asistencia.idAsistencia],
    );
    await cerrarDB(db);
  }

  // Método para eliminar una asistencia de la base de datos
  static Future<void> eliminarAsistencia(int idAsistencia) async {
    Database db = await _abrirDB();
    await db.delete(
      'ASISTENCIA',
      where: "IDASISTENCIA = ?",
      whereArgs: [idAsistencia],
    );
    await cerrarDB(db);
  } //-

   // Método para insertar un nuevo horario en la base de datos
static Future<void> insertarHorario(Horario horario) async {
  Database db = await _abrirDB();
  await db.insert(
    'HORARIO',
    horario.toJsonExcludingId(), // Llama a un método que excluye el campo NHORARIO
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  await cerrarDB(db);
}
  // Método para obtener todos los horarios de la base de datos
  static Future<List<Horario>> obtenerTodosLosHorarios() async {
    Database db = await _abrirDB();
    final List<Map<String, dynamic>> horariosMap = await db.query('HORARIO');
    await cerrarDB(db);
    return List.generate(horariosMap.length, (i) {
      return Horario(
        nHorario: horariosMap[i]['NHORARIO'],
        nProfesor: horariosMap[i]['NPROFESOR'],
        nMat: horariosMap[i]['NMAT'],
        hora: horariosMap[i]['HORA'],
        edificio: horariosMap[i]['EDIFICIO'],
        salon: horariosMap[i]['SALON'],
      );
    });
  }

  // Método para actualizar un horario en la base de datos
  static Future<void> actualizarHorario(Horario horario) async {
    Database db = await _abrirDB();
    await db.update(
      'HORARIO',
      horario.toJson(),
      where: "NHORARIO = ?",
      whereArgs: [horario.nHorario],
    );
    await cerrarDB(db);
  }

  // Método para eliminar un horario de la base de datos
  static Future<void> eliminarHorario(int nHorario) async {
    Database db = await _abrirDB();
    await db.delete(
      'HORARIO',
      where: "NHORARIO = ?",
      whereArgs: [nHorario],
    );
    await cerrarDB(db);
  }

  // Método para cerrar la base de datos
  static Future<void> cerrarDB(Database db) async {
    await db.close();
  }

  // Método para inicializar la base de datos
  static Future<void> inicializarDB() async {
    Database db = await _abrirDB();
    await cerrarDB(db);
  }

//avanzadas 
static Future<List<String>> obtenerProfesoresEnHorarioYEdificio({
  required String hora,
  required String edificio,
}) async {
  try {
    Database db = await _abrirDB();

    List<Map<String, dynamic>> resultados = await db.rawQuery('SELECT p.nombre FROM Profesor p INNER JOIN Horario h ON p.nProfesor = h.nProfesor WHERE h.hora = ? AND h.edificio = ?'
    , [hora, edificio]);

    await cerrarDB(db);

    // Convertir los resultados en una lista de nombres de profesores
    List<String> profesores = [];
    for (var resultado in resultados) {
      String? nombre = resultado['nombre'];
      if (nombre != null) {
        profesores.add(nombre);
      }
    }

    return profesores;
  } catch (e) {

    print('Error al obtener profesores: $e');
    return [];
  }
}
}