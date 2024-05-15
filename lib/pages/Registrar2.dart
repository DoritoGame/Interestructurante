import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registrar2 extends StatefulWidget {
  @override
  _Registrar2State createState() => _Registrar2State();
}

class _Registrar2State extends State<Registrar2> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showPassword = false;

  void _registrarCorreoContrasena(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Envío de correo electrónico de verificación
      await userCredential.user!.sendEmailVerification();

      // Registro exitoso
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Registro exitoso',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                color: Colors.white,
              ),
            ),
            content: Text(
              '¡Tu cuenta ha sido registrada exitosamente! Se ha enviado un correo electrónico de verificación.',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 70, 70, 69),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Cierra el cuadro de diálogo
                  Navigator.pop(
                      context); // Regresa a la página anterior (Registrar2)
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error al registrar con correo y contraseña: $e');
      // Manejo de errores, puedes mostrar un mensaje al usuario si el registro falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 70, 69),
      ),
      backgroundColor: const Color.fromARGB(255, 58, 59, 52),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                labelStyle: TextStyle(
                  fontFamily: 'Times New Roman',
                  color: Colors.white,
                ),
              ),
              style: TextStyle(
                fontFamily: 'Times New Roman',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  fontFamily: 'Times New Roman',
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  color: Colors.white,
                ),
              ),
              obscureText:
                  !_showPassword, // Oculta la contraseña si _showPassword es false
              style: TextStyle(
                fontFamily: 'Times New Roman',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                labelStyle: TextStyle(
                  fontFamily: 'Times New Roman',
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  color: Colors.white,
                ),
              ),
              obscureText:
                  !_showPassword, // Oculta la contraseña si _showPassword es false
              style: TextStyle(
                fontFamily: 'Times New Roman',
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_passwordController.text ==
                    _confirmPasswordController.text) {
                  _registrarCorreoContrasena(context);
                } else {
                  // Si las contraseñas no coinciden, muestra un mensaje al usuario
                  print('Las contraseñas no coinciden');
                }
              },
              child: Text(
                'Registrarse con correo y contraseña',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 21, 73, 105),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
