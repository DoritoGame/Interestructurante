import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/FirebaseService.dart';
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
        title: Text(
          'Buscar Usuario',
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 70, 69),
      ),
      backgroundColor: const Color.fromARGB(255, 58, 59, 52),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cedulaController,
              decoration: InputDecoration(
                labelText: 'Cédula',
                labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    color: Color.fromRGBO(245, 245, 245, 1)),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(245, 245, 245, 1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(245, 245, 245, 1)),
                ),
              ),
              style: TextStyle(
                  fontFamily: 'Times New Roman',
                  color: Color.fromRGBO(245, 245, 245, 1)),
              cursorColor: Color.fromRGBO(245, 245, 245, 1),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _buscarUsuario,
              child: Text(
                'Buscar',
                style: TextStyle(fontFamily: 'Times New Roman'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 21, 73, 105),
              ),
            ),
            SizedBox(height: 16.0),
            if (_userData != null)
              Expanded(
                child: UserDataWidget(
                  userData: _userData!,
                  onDelete: _deleteUser,
                  onEmailTap: _showEmailDialog,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteUser(UserData userData) async {
    bool confirmarEliminacion = await showDialog(
      context: context,
      builder: (BuildContext context) {
        BuildContext dialogContext = context;
        return AlertDialog(
          title: const Text("Confirmar eliminación"),
          content:
              const Text("¿Está seguro de que desea eliminar este usuario?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: Text("Eliminar"),
            ),
          ],
        );
      },
    );
    if (confirmarEliminacion ?? false) {
      try {
        await FirebaseService.deleteUserDataByCedula(userData.cedula);
        print("Usuario eliminado de Firestore");
      } catch (error) {
        print("Error al eliminar usuario de Firestore: $error");
      }
    }
  }

  Future<void> _showEmailDialog(String email) async {
    String selectedNotification = 'Notification De Pago';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enviar notificación a $email'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Correo electrónico: $email'),
              DropdownButton<String>(
                value: selectedNotification,
                onChanged: (String? value) {
                  setState(() {
                    selectedNotification = value!;
                  });
                },
                items: <String>[
                  'Notification De Pago',
                  'Notification De Ofertas Especiales',
                  'Notification De Actualizacion De Horarios'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _sendNotificationByEmail(email, selectedNotification);
                Navigator.of(context).pop();
              },
              child: Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendNotificationByEmail(
      String email, String notificationType) async {
    try {
      await FirebaseService.sendEmailNotification(email, notificationType);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correo electrónico enviado con éxito'),
        ),
      );
    } catch (e) {
      print('Error sending email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar el correo electrónico'),
        ),
      );
    }
  }
}

class UserDataWidget extends StatelessWidget {
  final UserData userData;
  final Function(UserData) onDelete; // Nueva función de devolución de llamada
  final Function(String) onEmailTap; // Nueva función de devolución de llamada

  UserDataWidget({
    required this.userData,
    required this.onDelete, // Agregar parámetro aquí
    required this.onEmailTap, // Agregar parámetro aquí
  });

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
      color: Color.fromARGB(255, 70, 70, 69),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información del usuario (nombre, cedula, edad, etc.)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userData.nombre} ${userData.apellido}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Cedula: ${userData.cedula}',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Edad: ${userData.edad}',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Fecha de Cumpleaños: $formattedBirthdayDate',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Correo: ${userData.correo}',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Genero: ${userData.genero}',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Membresia: ${userData.priority}',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Fecha de inicio: $formattedStartDate',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Fecha de fin: $formattedDueDate',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                  Text(
                    'Tipo de pago: ${userData.pago}',
                    style: TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Color.fromRGBO(245, 245, 245, 1),
                    ),
                  ),
                ],
              ),
            ),
            // Botones de eliminar y enviar correo
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    onDelete(userData);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.email),
                  color: Colors.blue,
                  onPressed: () {
                    onEmailTap(userData.correo);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
