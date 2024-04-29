import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/pages/visualizar.dart';

void main() {
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void verificarCredenciales(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      String usuario = usuarioController.text;
      String contrasena = contrasenaController.text;

      if (usuario == 'Puendos' && contrasena == 'Puendos') {
        mostrarDialogo(
            context, 'Secion iniciada correctamente', '¡Bienvenido!');
      } else {
        mostrarDialogo(context, 'Error de inicio de secion',
            'Credenciales incorrectas. Porfavor vuelva a introducir credenciales');
      }
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
                "assets/gimnasio-fitness-hombres-retro_48832-270.avif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Iniciar Sesion",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Times New Roman'),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: usuarioController,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Times New Roman'),
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(50, 217, 214, 214),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: contrasenaController,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Times New Roman'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(50, 217, 214, 214),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      verificarCredenciales(context);
                      // Aquí se redirige a la otra página si las credenciales son correctas
                      if (usuarioController.text == 'Puendos' &&
                          contrasenaController.text == 'Puendos') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TodoApp()),
                        );
                      }
                    },
                    child: Text('Iniciar Sesion',
                        style: TextStyle(fontFamily: 'Times New Roman')),
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
      ),
    );
  }
}
