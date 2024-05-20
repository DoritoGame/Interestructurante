import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';

class BuscarPage extends StatefulWidget {
  @override
  _BuscarPageState createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  final TextEditingController _cedulaController = TextEditingController();
  UserData? _userData;

  Future<void> _buscarUsuario() async {
    final cedulaIngresada = int.tryParse(_cedulaController.text.trim());

    if (cedulaIngresada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, ingresa un número de cédula válido'),
        ),
      );
      return;
    }

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('clientes')
          .where('cedula', isEqualTo: cedulaIngresada)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = UserData.fromJson(querySnapshot.docs.first.data());
        setState(() {
          _userData = userData;
        });
      } else {
        setState(() {
          _userData = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se encontró ningún usuario con esa cédula'),
          ),
        );
      }
    } catch (e) {
      print('Error buscando usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al buscar el usuario'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cedulaController,
              decoration: InputDecoration(
                labelText: 'Cédula',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _buscarUsuario,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            if (_userData != null)
              Expanded(
                child: UserDataWidget(userData: _userData!),
              ),
          ],
        ),
      ),
    );
  }
}

class UserDataWidget extends StatelessWidget {
  final UserData userData;

  UserDataWidget({required this.userData});

  @override
  Widget build(BuildContext context) {
    String? formattedBirthdayDate;
    String? formattedStartDate;
    String? formattedDueDate;

    if (userData.BirthadayDate != null) {
      Timestamp birthdayDate = userData.BirthadayDate!;
      formattedBirthdayDate =
          "${birthdayDate.toDate().day.toString().padLeft(2, '0')}/${birthdayDate.toDate().month.toString().padLeft(2, '0')}/${birthdayDate.toDate().year.toString()}";
    }

    if (userData.startDate != null) {
      Timestamp startDate = userData.startDate!;
      formattedStartDate =
          "${startDate.toDate().day.toString().padLeft(2, '0')}/${startDate.toDate().month.toString().padLeft(2, '0')}/${startDate.toDate().year.toString()}";
    }

    if (userData.dueDate != null) {
      Timestamp dueDate = userData.dueDate!;
      formattedDueDate =
          "${dueDate.toDate().day.toString().padLeft(2, '0')}/${dueDate.toDate().month.toString().padLeft(2, '0')}/${dueDate.toDate().year.toString()}";
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '               ${userData.nombre}  ${userData.apellido}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text('Cedula: ${userData.cedula}'),
            Text('Edad: ${userData.edad}'),
            Text('Fecha de Cumpleaños: $formattedBirthdayDate'),
            Text('Correo: ${userData.correo}'),
            Text('Genero: ${userData.genero}'),
            Text('Membresia: ${userData.priority}'),
            Text('Fecha de inicio: $formattedStartDate'),
            Text('Fecha de fin: $formattedDueDate'),
            Text('Tipo de pago: ${userData.pago}'),
          ],
        ),
      ),
    );
  }
}
