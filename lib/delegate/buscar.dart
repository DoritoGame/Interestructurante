import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';

class BuscarPorCedula extends StatelessWidget {
  final List<UserData> tasks;
  final TextEditingController cedulaController = TextEditingController();

  BuscarPorCedula({required this.tasks});

  void _buscarPorCedula(BuildContext context) {
    String cedula = cedulaController.text;
    UserData? usuarioEncontrado = tasks.firstWhere(
        (task) => task.cedula == int.parse(cedula),
        orElse: () => UserData(0, '', '', 0, '', null, null, null, '', '', '',
            isComplete: false));

    if (usuarioEncontrado != null) {
      // Aquí puedes hacer lo que quieras con el usuario encontrado,
      // como mostrarlo en una lista o realizar alguna otra acción.
      print('Usuario encontrado: $usuarioEncontrado');
    } else {
      // Si no se encuentra ningún usuario con la cédula ingresada, puedes mostrar un mensaje o realizar otra acción.
      print('No se encontró ningún usuario con la cédula $cedula');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar por Cédula'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: cedulaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese la cédula',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _buscarPorCedula(context);
              },
              child: Text('Buscar'),
            ),
          ],
        ),
      ),
    );
  }
}
