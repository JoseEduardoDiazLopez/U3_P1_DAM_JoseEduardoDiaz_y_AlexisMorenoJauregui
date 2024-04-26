import 'package:flutter/material.dart';
import 'Profesor.dart';
import 'BaseDatos.dart';
import 'Asistencia.dart';
import 'Horario.dart';
import 'Materia.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.inicializarDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Asistencia',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ProfesoresListPage(),
    MateriasListPage(),
    HorariosListPage(),
    AsistenciasListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de Asistencia'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Lista de Profesores',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaProfesoresPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Lista de Materias',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaMateriasPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Lista de Horarios',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaHorariosListPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Lista de Asistencias',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaAsistenciasPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Consultas Avanzadas',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BusquedaProfesoresScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profesores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Materias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Horarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Asistencias',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ListaMateriasPage extends StatefulWidget {
  @override
  _ListaMateriasPageState createState() => _ListaMateriasPageState();
}

class _ListaMateriasPageState extends State<ListaMateriasPage> {
  List<Materia> _materias = [];

  @override
  void initState() {
    super.initState();
    _cargarMaterias();
  }

  Future<void> _cargarMaterias() async {
    List<Materia> materias = await DB.obtenerTodasLasMaterias();
    setState(() {
      _materias = materias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Materias'),
      ),
      body: ListView.builder(
        itemCount: _materias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_materias[index].nMat),
            subtitle: Text(_materias[index].descripcion),
            onTap: () {
              Navigator.pop(context, _materias[index]);
            },
          );
        },
      ),
    );
  }
}
//lista ASISTENCIAS

class ListaAsistenciasPage extends StatefulWidget {
  @override
  _ListaAsistenciasPageState createState() => _ListaAsistenciasPageState();
}

class _ListaAsistenciasPageState extends State<ListaAsistenciasPage> {
  List<Asistencia> _asistencias = [];

  @override
  void initState() {
    super.initState();
    _cargarAsistencias();
  }

  Future<void> _cargarAsistencias() async {
    List<Asistencia> asistencias = await DB.obtenerTodasLasAsistencias();
    setState(() {
      _asistencias = asistencias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Asistencias'),
      ),
      body: ListView.builder(
        itemCount: _asistencias.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('ID Asistencia: ${_asistencias[index].idAsistencia}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID Horario: ${_asistencias[index].nHorario}'),
                Text('Fecha: ${_asistencias[index].fecha}'),
                Text(
                    'Asistencia: ${_asistencias[index].asistencia ? 'Presente' : 'Ausente'}'),
              ],
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}

//LISTA HORATIOS
class ListaHorariosListPage extends StatefulWidget {
  @override
  _ListaHorariosListPageState createState() => _ListaHorariosListPageState();
}

class _ListaHorariosListPageState extends State<ListaHorariosListPage> {
  List<Horario> _horarios = [];

  @override
  void initState() {
    super.initState();
    _cargarHorarios();
  }

  Future<void> _cargarHorarios() async {
    List<Horario> horarios = await DB.obtenerTodosLosHorarios();
    setState(() {
      _horarios = horarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Horarios'),
      ),
      body: ListView.builder(
        itemCount: _horarios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                'Profesor: ${_horarios[index].nProfesor} - Materia: ${_horarios[index].nMat}'),
            subtitle: Text(
                'Hora: ${_horarios[index].hora} - Edificio: ${_horarios[index].edificio} - Salón: ${_horarios[index].salon}'),
          );
        },
      ),
    );
  }
}

class ListaProfesoresPage extends StatefulWidget {
  @override
  _ListaProfesoresPageState createState() => _ListaProfesoresPageState();
}

class _ListaProfesoresPageState extends State<ListaProfesoresPage> {
  List<Profesor> _profesores = [];

  @override
  void initState() {
    super.initState();
    _cargarProfesores();
  }

  Future<void> _cargarProfesores() async {
    List<Profesor> profesores = await DB.obtenerTodosLosProfesores();
    setState(() {
      _profesores = profesores;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Profesores'),
      ),
      body: ListView.builder(
        itemCount: _profesores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                'Número: ${_profesores[index].nProfesor}, ${_profesores[index].nombre}'),
            subtitle: Text(_profesores[index].carrera),
          );
        },
      ),
    );
  }
}
// Profesores

class ProfesoresListPage extends StatelessWidget {
  final TextEditingController nProfesorController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController carreraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Profesores'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInsertForm(context),
            _buildUpdateForm(context),
            _buildDeleteForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInsertForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Insertar Profesor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nProfesorController,
                decoration: InputDecoration(labelText: 'ID de Profesor'),
              ),
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: carreraController,
                decoration: InputDecoration(labelText: 'Carrera'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.insertarProfesor(
                    Profesor(
                      nProfesor: nProfesorController.text,
                      nombre: nombreController.text,
                      carrera: carreraController.text,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profesor insertado correctamente')),
                  );
                  _limpiarCampos(
                      nProfesorController, nombreController, carreraController);
                },
                child: Text('Insertar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateForm(BuildContext context) {
    final TextEditingController nProfesorUpdateController =
        TextEditingController();
    final TextEditingController nombreUpdateController =
        TextEditingController();
    final TextEditingController carreraUpdateController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Actualizar Profesor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nProfesorUpdateController,
                decoration:
                    InputDecoration(labelText: 'ID de Profesor a actualizar'),
              ),
              TextFormField(
                controller: nombreUpdateController,
                decoration: InputDecoration(labelText: 'Nuevo Nombre'),
              ),
              TextFormField(
                controller: carreraUpdateController,
                decoration: InputDecoration(labelText: 'Nueva Carrera'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.actualizarProfesor(
                    Profesor(
                      nProfesor: nProfesorUpdateController.text,
                      nombre: nombreUpdateController.text,
                      carrera: carreraUpdateController.text,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Profesor actualizado correctamente')),
                  );
                  _limpiarCampos(nProfesorUpdateController,
                      nombreUpdateController, carreraUpdateController);
                },
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteForm(BuildContext context) {
    final TextEditingController nProfesorDeleteController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Eliminar Profesor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nProfesorDeleteController,
                decoration:
                    InputDecoration(labelText: 'ID de Profesor a eliminar'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.eliminarProfesor(nProfesorDeleteController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profesor eliminado correctamente')),
                  );
                  _limpiarCampos(nProfesorDeleteController);
                },
                child: Text('Eliminar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _limpiarCampos(TextEditingController controller1,
      [TextEditingController? controller2,
      TextEditingController? controller3]) {
    controller1.clear();
    controller2?.clear();
    controller3?.clear();
  }
}

//MATERIAS

class MateriasListPage extends StatelessWidget {
  final TextEditingController nMateriaController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  void _limpiarCampos(TextEditingController controller1,
      [TextEditingController? controller2]) {
    controller1.clear();
    controller2?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Materias'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInsertForm(context),
            _buildUpdateForm(context), 
            _buildDeleteForm(context), 
          ],
        ),
      ),
    );
  }

  Widget _buildInsertForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Insertar Materia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nMateriaController,
                decoration: InputDecoration(labelText: 'ID de Materia'),
              ),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.insertarMateria(
                    Materia(
                      nMat: nMateriaController.text,
                      descripcion: descripcionController.text,
                    ),
                  );
                  _limpiarCampos(nMateriaController, descripcionController);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Materia insertada correctamente')),
                  );
                },
                child: Text('Insertar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateForm(BuildContext context) {
    final TextEditingController nMateriaUpdateController =
        TextEditingController();
    final TextEditingController descripcionUpdateController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Actualizar Materia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nMateriaUpdateController,
                decoration:
                    InputDecoration(labelText: 'ID de Materia a actualizar'),
              ),
              TextFormField(
                controller: descripcionUpdateController,
                decoration: InputDecoration(labelText: 'Nueva Descripción'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.actualizarMateria(
                    Materia(
                      nMat: nMateriaUpdateController.text,
                      descripcion: descripcionUpdateController.text,
                    ),
                  );
                  _limpiarCampos(
                      nMateriaUpdateController, descripcionUpdateController);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Materia actualizada correctamente')),
                  );
                },
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteForm(BuildContext context) {
    final TextEditingController nMateriaDeleteController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Eliminar Materia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nMateriaDeleteController,
                decoration:
                    InputDecoration(labelText: 'ID de Materia a eliminar'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.eliminarMateria(nMateriaDeleteController.text);
                  _limpiarCampos(nMateriaDeleteController);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Materia eliminada correctamente')),
                  );
                },
                child: Text('Eliminar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HORARIO

class HorariosListPage extends StatelessWidget {
  final TextEditingController nProfesorController = TextEditingController();
  final TextEditingController nMatController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController edificioController = TextEditingController();
  final TextEditingController salonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Horarios'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInsertForm(context),
            _buildUpdateForm(context),
            _buildDeleteForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInsertForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Insertar Horario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nProfesorController,
                decoration: InputDecoration(labelText: 'ID de Profesor'),
              ),
              TextFormField(
                controller: nMatController,
                decoration: InputDecoration(labelText: 'ID de Materia'),
              ),
              TextFormField(
                controller: horaController,
                decoration: InputDecoration(labelText: 'Hora'),
              ),
              TextFormField(
                controller: edificioController,
                decoration: InputDecoration(labelText: 'Edificio'),
              ),
              TextFormField(
                controller: salonController,
                decoration: InputDecoration(labelText: 'Salón'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.insertarHorario(
                    Horario(
                      nProfesor: nProfesorController.text,
                      nMat: nMatController.text,
                      hora: horaController.text,
                      edificio: edificioController.text,
                      salon: salonController.text,
                    ),
                  );
                  _limpiarCampos(
                      nProfesorController,
                      nMatController,
                      horaController,
                      edificioController,
                      salonController,
                      null);
                  _mostrarSnackBar(context, 'Horario insertado exitosamente');
                },
                child: Text('Insertar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateForm(BuildContext context) {
    final TextEditingController nHorarioUpdateController =
        TextEditingController();
    final TextEditingController nProfesorUpdateController =
        TextEditingController();
    final TextEditingController nMatUpdateController = TextEditingController();
    final TextEditingController horaUpdateController = TextEditingController();
    final TextEditingController edificioUpdateController =
        TextEditingController();
    final TextEditingController salonUpdateController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Actualizar Horario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nHorarioUpdateController,
                decoration:
                    InputDecoration(labelText: 'ID de Horario a actualizar'),
              ),
              TextFormField(
                controller: nProfesorUpdateController,
                decoration: InputDecoration(labelText: 'Nuevo ID de Profesor'),
              ),
              TextFormField(
                controller: nMatUpdateController,
                decoration: InputDecoration(labelText: 'Nuevo ID de Materia'),
              ),
              TextFormField(
                controller: horaUpdateController,
                decoration: InputDecoration(labelText: 'Nueva Hora'),
              ),
              TextFormField(
                controller: edificioUpdateController,
                decoration: InputDecoration(labelText: 'Nuevo Edificio'),
              ),
              TextFormField(
                controller: salonUpdateController,
                decoration: InputDecoration(labelText: 'Nuevo Salón'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.actualizarHorario(
                    Horario(
                      nHorario: int.parse(nHorarioUpdateController.text),
                      nProfesor: nProfesorUpdateController.text,
                      nMat: nMatUpdateController.text,
                      hora: horaUpdateController.text,
                      edificio: edificioUpdateController.text,
                      salon: salonUpdateController.text,
                    ),
                  );
                  _limpiarCampos(
                      nHorarioUpdateController,
                      nProfesorUpdateController,
                      nMatUpdateController,
                      horaUpdateController,
                      edificioUpdateController,
                      salonUpdateController);
                  _mostrarSnackBar(context, 'Horario actualizado exitosamente');
                },
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteForm(BuildContext context) {
    final TextEditingController nHorarioDeleteController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Eliminar Horario',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nHorarioDeleteController,
                decoration:
                    InputDecoration(labelText: 'ID de Horario a eliminar'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.eliminarHorario(
                      int.parse(nHorarioDeleteController.text));
                  _limpiarCampos(
                      nHorarioDeleteController, null, null, null, null, null);
                  _mostrarSnackBar(context, 'Horario eliminado exitosamente');
                },
                child: Text('Eliminar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _limpiarCampos(
    TextEditingController controller1,
    TextEditingController? controller2,
    TextEditingController? controller3,
    TextEditingController? controller4,
    TextEditingController? controller5,
    TextEditingController? controller6,
  ) {
    controller1.clear();
    controller2?.clear();
    controller3?.clear();
    controller4?.clear();
    controller5?.clear();
    controller6?.clear();
  }

  void _mostrarSnackBar(BuildContext context, String mensaje) {
    final snackBar = SnackBar(content: Text(mensaje));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

//avanzada1
class BusquedaProfesoresScreen extends StatefulWidget {
  @override
  _BusquedaProfesoresScreenState createState() =>
      _BusquedaProfesoresScreenState();
}

class _BusquedaProfesoresScreenState extends State<BusquedaProfesoresScreen> {
  TextEditingController _horaController = TextEditingController();
  TextEditingController _edificioController = TextEditingController();
  List<String> _profesores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Profesores por Edificio y Hora'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _horaController,
              decoration:
                  InputDecoration(labelText: 'Ingresa la Hora (ej. 8:00 AM)'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _edificioController,
              decoration: InputDecoration(labelText: 'Ingresa el Edificio'),
            ),
            SizedBox(height: 20.0),
           ElevatedButton(
  onPressed: () async {
    String hora = _horaController.text;
    String edificio = _edificioController.text;
    print('Hora: $hora, Edificio: $edificio'); 
    try {
      List<String> profesores = await DB.obtenerProfesoresEnHorarioYEdificio(
        hora: hora,
        edificio: edificio,
      );
      print('Profesores encontrados: $profesores'); 
      setState(() {
        _profesores = profesores;
      });
    } catch (e) {
      print('Error al obtener profesores: $e');
    }
    // Limpiar los campos de texto después de realizar la búsqueda
    _horaController.clear();
    _edificioController.clear();
  },
  child: Text('Buscar'),
),

            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _profesores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_profesores[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//ASISTENCIAS

class AsistenciasListPage extends StatefulWidget {
  @override
  _AsistenciasListPageState createState() => _AsistenciasListPageState();
}

class _AsistenciasListPageState extends State<AsistenciasListPage> {
  final TextEditingController nHorarioController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  bool asistencia = false;

  List<Asistencia> _asistencias = [];

  @override
  void initState() {
    super.initState();
    _cargarAsistencias();
  }

  Future<void> _cargarAsistencias() async {
    List<Asistencia> asistencias = await DB.obtenerTodasLasAsistencias();
    setState(() {
      _asistencias = asistencias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Asistencias'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInsertForm(context),
            _buildUpdateForm(context),
            _buildDeleteForm(context),
            _buildAsistenciasList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInsertForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Insertar Asistencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nHorarioController,
                decoration: InputDecoration(labelText: 'ID de Horario'),
              ),
              TextFormField(
                controller: fechaController,
                decoration: InputDecoration(labelText: 'Fecha'),
              ),
              Row(
                children: [
                  Text('Asistencia: '),
                  Checkbox(
                    value: asistencia,
                    onChanged: (value) {
                      setState(() {
                        asistencia = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.insertarAsistencia(
                    Asistencia(
                      idAsistencia:
                          0, 
                      nHorario: int.parse(nHorarioController.text),
                      fecha: fechaController.text,
                      asistencia: asistencia,
                    ),
                  );
                  _limpiarCampos(nHorarioController, fechaController);
                  _cargarAsistencias();
                  _mostrarSnackBar(
                      context, 'Asistencia insertada exitosamente');
                },
                child: Text('Insertar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateForm(BuildContext context) {
    final TextEditingController idAsistenciaUpdateController =
        TextEditingController();
    final TextEditingController nHorarioUpdateController =
        TextEditingController();
    final TextEditingController fechaUpdateController = TextEditingController();
    bool asistenciaUpdate = false;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Actualizar Asistencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: idAsistenciaUpdateController,
                decoration:
                    InputDecoration(labelText: 'ID de Asistencia a actualizar'),
              ),
              TextFormField(
                controller: nHorarioUpdateController,
                decoration: InputDecoration(labelText: 'Nuevo ID de Horario'),
              ),
              TextFormField(
                controller: fechaUpdateController,
                decoration: InputDecoration(labelText: 'Nueva Fecha'),
              ),
              Row(
                children: [
                  Text('Nueva Asistencia: '),
                  Checkbox(
                    value: asistenciaUpdate,
                    onChanged: (value) {
                      setState(() {
                        asistenciaUpdate = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.actualizarAsistencia(
                    Asistencia(
                      idAsistencia:
                          int.parse(idAsistenciaUpdateController.text),
                      nHorario: int.parse(nHorarioUpdateController.text),
                      fecha: fechaUpdateController.text,
                      asistencia: asistenciaUpdate,
                    ),
                  );
                  _limpiarCampos(idAsistenciaUpdateController,
                      nHorarioUpdateController, fechaUpdateController);
                  _cargarAsistencias();
                  _mostrarSnackBar(
                      context, 'Asistencia actualizada exitosamente');
                },
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteForm(BuildContext context) {
    final TextEditingController idAsistenciaDeleteController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Eliminar Asistencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: idAsistenciaDeleteController,
                decoration:
                    InputDecoration(labelText: 'ID de Asistencia a eliminar'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await DB.eliminarAsistencia(
                      int.parse(idAsistenciaDeleteController.text));
                  _limpiarCampos(idAsistenciaDeleteController);
                  _cargarAsistencias();
                  _mostrarSnackBar(
                      context, 'Asistencia eliminada exitosamente');
                },
                child: Text('Eliminar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAsistenciasList(BuildContext context) {
    return Column(
      children: _asistencias.map((asistencia) {
        return ListTile(
          title: Text(
              'ID: ${asistencia.idAsistencia} - Horario: ${asistencia.nHorario} - Fecha: ${asistencia.fecha} - Asistencia: ${asistencia.asistencia}'),
        );
      }).toList(),
    );
  }

  void _limpiarCampos(TextEditingController controller1,
      [TextEditingController? controller2,
      TextEditingController? controller3]) {
    controller1.clear();
    controller2?.clear();
    controller3?.clear();
    setState(() {
      asistencia = false; 
    });
  }

  void _mostrarSnackBar(BuildContext context, String mensaje) {
    final snackBar = SnackBar(content: Text(mensaje));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
