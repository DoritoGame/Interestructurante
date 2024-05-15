import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/pages/Registrar2.dart';
import 'package:gimnaciomusculoso/pages/Usuario.dart';
import 'package:gimnaciomusculoso/pages/visualizar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initLocalAuthentication();
    _checkLoggedIn();
  }

  void _initLocalAuthentication() async {
    _canCheckBiometrics = await auth.canCheckBiometrics;
  }

  void _checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      usuarioController.text = email;
      contrasenaController.text = password;
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  Future<void> _verificarCredenciales(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: usuarioController.text,
        password: contrasenaController.text,
      );
      if (userCredential != null) {
        final String userEmail = userCredential.user!.email!;
        if (userEmail.endsWith('@gmail.com')) {
          _saveCredentials(usuarioController.text, contrasenaController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UsuarioPage(
                    nombreUsuario: userCredential.user!.displayName ?? '')),
          );
        } else if (userEmail.endsWith('@unicesmag.edu.co')) {
          _saveCredentials(usuarioController.text, contrasenaController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TodoApp()),
          );
        } else {
          _saveCredentials(usuarioController.text, contrasenaController.text);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Registrar2()),
          );
        }
      }
    } catch (e) {
      mostrarDialogo(context, 'Error de inicio de sesión', e.toString());
    }
  }

  Future<void> _saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  Future<void> authenticateWithFingerprint(BuildContext context) async {
    if (!_canCheckBiometrics) {
      mostrarDialogo(context, 'Error',
          'No se puede autenticar con huella digital en este dispositivo');
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Autenticación requerida',
          options: const AuthenticationOptions(biometricOnly: true),
        );

        if (didAuthenticate) {
          final UserCredential userCredential =
              await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          if (userCredential != null) {
            final String userEmail = userCredential.user!.email!;
            if (userEmail.endsWith('@gmail.com')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => UsuarioPage(
                        nombreUsuario: userCredential.user!.displayName ?? '')),
              );
            } else if (userEmail.endsWith('@unicesmag.edu.co')) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TodoApp()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Registrar2()),
              );
            }
          }
        } else {
          mostrarDialogo(
              context, 'Error de autenticación', 'Autenticación fallida');
        }
      } catch (e) {
        mostrarDialogo(context, 'Error de autenticación', e.toString());
      }
    } else {
      mostrarDialogo(context, 'Credenciales no encontradas',
          'Primero debe ingresar su correo electrónico y contraseña antes de usar la autenticación con huella digital.');
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

  Future<void> _checkAndAuthenticate(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      await _authenticateWithEmail(context, email, password);
    } else {
      await _authenticateWithEmail(
          context, '', ''); // Llamar a la autenticación manualmente
    }
  }

  Future<void> _authenticateWithEmail(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        final String userEmail = userCredential.user!.email!;
        if (userEmail.endsWith('@gmail.com')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UsuarioPage(
                    nombreUsuario: userCredential.user!.displayName ?? '')),
          );
        } else if (userEmail.endsWith('@unicesmag.edu.co')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TodoApp()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Registrar2()),
          );
        }
      }
    } catch (e) {
      mostrarDialogo(context, 'Error de inicio de sesión', e.toString());
    }
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
            child: _isLoggedIn
                ? ElevatedButton(
                    onPressed: () {
                      authenticateWithFingerprint(context);
                    },
                    child: Text(
                      'Autenticación con huella digital',
                      style: TextStyle(fontFamily: 'Times New Roman'),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(90, 214, 217, 215)),
                    ),
                  )
                : Column(
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
                          _verificarCredenciales(context);
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
                            MaterialPageRoute(
                                builder: (context) => Registrar2()),
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
