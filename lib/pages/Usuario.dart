import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/main.dart';

class UsuarioPage extends StatefulWidget {
  final String nombreUsuario;

  const UsuarioPage({Key? key, required this.nombreUsuario}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  List<Map<String, String>> _rutinasPiernas = [
    {'nombre': 'Sentadillas', 'imagen': 'assets/Sentadillas.png'},
    {'nombre': 'Zancadas', 'imagen': 'assets/Zancadas.png'},
    {'nombre': 'Prensa de piernas', 'imagen': 'assets/prensa_piernas.png'},
    {
      'nombre': 'Extensiones de piernas',
      'imagen': 'assets/extensiones_piernas.png'
    },
    {'nombre': 'Curl de piernas', 'imagen': 'assets/curl_piernas.png'},
  ];

  List<Map<String, String>> _rutinasPecho = [
    {
      'nombre': 'Press de banca',
      'imagen': 'assets/Press-de-banca-con-barra.jpg'
    },
    {
      'nombre': 'Flexiones de pecho',
      'imagen': 'assets/flexiones-sobre-mancuernas-init-pos-2765.png'
    },
    {
      'nombre': 'Pull over con mancuerna',
      'imagen': 'assets/pullover-con-mancuerna-en-banco-plano-init-pos-2566.png'
    },
    {
      'nombre': 'Aperturas con mancuernas',
      'imagen': 'assets/Aperturas con mancuernas.png'
    },
  ];

  List<Map<String, String>> _rutinasEspalda = [
    {'nombre': 'Dominadas', 'imagen': 'assets/Dominadas.png'},
    {'nombre': 'Remo con barra', 'imagen': 'assets/Remo con barra.png'},
    {'nombre': 'Peso muerto', 'imagen': 'assets/Peso muerto.png'},
    {
      'nombre': 'Pull ups',
      'imagen': 'assets/u05-bottomhalfwaytop-ism-mh310118-1558552383.jpg'
    },
  ];

  List<Map<String, String>> _rutinasHombros = [
    {'nombre': 'Press militar', 'imagen': 'assets/Press militar.png'},
    {
      'nombre': 'Elevaciones laterales',
      'imagen': 'assets/Elevaciones laterales.png'
    },
    {
      'nombre': 'Elevaciones frontales',
      'imagen': 'assets/Elevaciones fron.png'
    },
    {'nombre': 'Pájaros con mancuernas', 'imagen': 'assets/pajaros1.jpg'},
  ];

  List<Map<String, String>> _rutinasCuerpo = [
    {'nombre': 'Burpees', 'imagen': 'assets/Burpees.png'},
    {
      'nombre': 'Flexiones de cuerpo',
      'imagen': 'assets/Flexiones de cuerpo.png'
    },
    {
      'nombre': 'Plancha - 30 segundos',
      'imagen': 'assets/Plancha - 30 segundos.png'
    },
    {'nombre': 'Mountain climbers', 'imagen': 'assets/Mountain climbers.png'},
  ];

  List<Map<String, String>> _rutinasSeleccionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido, ${widget.nombreUsuario}',
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 70, 69),
        actions: [
          IconButton(
            icon: Icon(Icons.person_2_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 58, 59, 52),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Botones de rutinas de gimnasio
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildBotonRutina('Rutinas para piernas', _rutinasPiernas),
                _buildBotonRutina('Rutinas para pecho', _rutinasPecho),
                _buildBotonRutina('Rutinas para espalda', _rutinasEspalda),
                _buildBotonRutina('Rutinas para hombros', _rutinasHombros),
                _buildBotonRutina(
                    'Rutinas para todo el cuerpo', _rutinasCuerpo),
              ],
            ),
          ),

          // Contenido adicional de la página de Usuario
          Expanded(
            child: Center(
              child: _rutinasSeleccionadas.isNotEmpty
                  ? ListView.builder(
                      itemCount: _rutinasSeleccionadas.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  _rutinasSeleccionadas[index]['imagen']!,
                                  width: 300,
                                  height: 300,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  _rutinasSeleccionadas[index]['nombre']!,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Times New Roman',
                                    color: Color.fromRGBO(245, 245, 245, 1),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '10 Repeticiones',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Times New Roman',
                                    color: Color.fromRGBO(245, 245, 245, 1),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Text(
                      'Selecciona una rutina.',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        color: Color.fromRGBO(245, 245, 245, 1),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotonRutina(String titulo, List<Map<String, String>> rutinas) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          _selectRutinasAleatorias(rutinas);
        },
        child: Column(
          children: [
            Text(
              titulo,
              style: TextStyle(fontFamily: 'Times New Roman'),
            ),
            SizedBox(height: 5),
            Image.asset(
              rutinas[0]['imagen']!,
              width: 100,
              height: 100,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 21, 73, 105),
        ),
      ),
    );
  }

  void _selectRutinasAleatorias(List<Map<String, String>> rutinas) {
    setState(() {
      _rutinasSeleccionadas = List.from(rutinas)..shuffle();
    });
  }
}
