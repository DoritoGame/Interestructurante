import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _showPassword =
      false; // Variable para controlar si se muestra la contraseña o no

  void _registrarCorreoContrasena(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Registro exitoso
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registro exitoso'),
            content: Text('¡Tu cuenta ha sido registrada exitosamente!'),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
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

  void _registrarConGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // Registro con Google exitoso
        print('Usuario registrado con Google: ${userCredential.user!.email}');
        // Redirigir a la página principal u otra página si es necesario
      }
    } catch (e) {
      print('Error al registrar con Google: $e');
      // Manejo de errores, puedes mostrar un mensaje al usuario si el registro falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              obscureText:
                  !_showPassword, // Oculta la contraseña si _showPassword es false
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              obscureText:
                  !_showPassword, // Oculta la contraseña si _showPassword es false
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
              child: Text('Registrarse con correo y contraseña'),
            ),
            SizedBox(height: 20.0),
            OutlinedButton.icon(
              onPressed: () {
                _registrarConGoogle(context);
              },
              icon: Icon(Icons.g_translate),
              label: Text('Registrarse con Google'),
            ),
          ],
        ),
      ),
    );
  }
}
