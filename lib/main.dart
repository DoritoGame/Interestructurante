import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/pages/Registrar2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gimnaciomusculoso/pages/Usuario.dart';
import 'package:gimnaciomusculoso/pages/visualizar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void verificarCredenciales(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: usuarioController.text,
        password: contrasenaController.text,
      );
      // Si el inicio de sesión es exitoso, determina la página a la que redirigir
      if (userCredential != null) {
        final String userEmail = userCredential.user!.email!;
        if (userEmail.endsWith('@gmail.com')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UsuarioPage()),
          );
        } else if (userEmail.endsWith('@unicesmag.edu.co')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TodoApp()),
          );
        } else {
          // Redirigir a una página predeterminada si el correo no coincide con ninguno
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Registrar2()),
          );
        }
      }
    } catch (e) {
      // Si ocurre un error al iniciar sesión, muestra un mensaje al usuario
      mostrarDialogo(context, 'Error de inicio de sesión', e.toString());
    }
  }

  void mostrarDialogo(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/gimnasio-fitness-hombres-retro_48832-270.avif",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: usuarioController,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color.fromARGB(50, 217, 214, 214),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: contrasenaController,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Times New Roman',
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color.fromARGB(50, 217, 214, 214),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    verificarCredenciales(context);
                  },
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(90, 214, 217, 215)),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registrar2()),
                    );
                  },
                  child: Text(
                    'Registrarse',
                    style: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(90, 214, 217, 215)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
