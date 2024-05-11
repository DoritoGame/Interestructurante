import 'dart:math';
import 'package:flutter/material.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({Key? key}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  List<String> _rutinasPiernas = [
    'Sentadillas',
    'Zancadas',
    'Prensa de piernas ',
    'Extensiones de piernas',
    'Curl de piernas',
  ];

  List<String> _rutinasPecho = [
    'Press de banca',
    'Flexiones de pecho',
    'Pull over con mancuerna',
    'Aperturas con mancuernas',
  ];

  List<String> _rutinasEspalda = [
    'Dominadas ',
    'Remo con barra',
    'Peso muerto ',
    'Pull ups ',
  ];

  List<String> _rutinasHombros = [
    'Press militar',
    'Elevaciones laterales',
    'Elevaciones frontales',
    'Pájaros con mancuernas',
  ];

  List<String> _rutinasCuerpo = [
    'Burpees',
    'Flexiones de cuerpo',
    'Plancha - 30 segundos',
    'Mountain climbers',
  ];

  List<String> _rutinasSeleccionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil de Usuario',
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Icono de perfil
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Acción al presionar el icono de perfil
            },
          ),
        ],
      ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _rutinasSeleccionadas[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Times New Roman',
                                ),
                              ),
                              Text(
                                '10 Repeticiones',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Times New Roman',
                                ),
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
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBotonRutina(String titulo, List<String> rutinas) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          _selectRutinasAleatorias(rutinas);
        },
        child: Text(
          titulo,
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
      ),
    );
  }

  void _selectRutinasAleatorias(List<String> rutinas) {
    setState(() {
      _rutinasSeleccionadas = List.from(rutinas)..shuffle();
    });
  }
}
