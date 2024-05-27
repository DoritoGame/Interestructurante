import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/FirebaseService.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';
import 'package:gimnaciomusculoso/delegate/buscar.dart';
import 'package:gimnaciomusculoso/main.dart';
import 'package:gimnaciomusculoso/pages/registrar.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<UserData> tasks = [];

  @override
  void initState() {
    super.initState();
    _getDataFromFirestore();
  }

  Future<void> _getDataFromFirestore() async {
    try {
      final userDataList = await FirebaseService.getAllUserData();
      setState(() {
        tasks.clear();
        tasks.addAll(userDataList);
      });
    } catch (error) {
      print("Error retrieving data from Firestore: $error");
    }
  }

  Future<void> _deleteUser(int index) async {
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
        await FirebaseService.deleteUserDataByCedula(tasks[index].cedula);

        print("Usuario eliminado de Firestore");

        setState(() {
          tasks.removeAt(index);
        });
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
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Registro',
          style: TextStyle(
            color: Color.fromRGBO(245, 245, 245, 1),
            fontFamily: 'Times New Roman',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 70, 70, 69),
        actions: [
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
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuscarPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _getDataFromFirestore,
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 58, 59, 52),
      body: TaskList(
          tasks: tasks, onDelete: _deleteUser, onEmailTap: _showEmailDialog),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrarPage()),
          ).then((newTask) {
            if (newTask != null) {
              setState(() {
                tasks.add(newTask);
                tasks.sort((a, b) {
                  final priorityValues = {
                    'Normal(50,000)': 0,
                    'Premiun(70,000)': 1,
                    'Golden(100,000)': 2
                  };
                  int priorityA = priorityValues[a.priority]!;
                  int priorityB = priorityValues[b.priority]!;
                  return priorityA.compareTo(priorityB);
                });
              });
            }
          });
        },
        backgroundColor: const Color.fromARGB(255, 21, 73, 105),
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<UserData> tasks;
  final Function(int) onDelete;
  final Function(String) onEmailTap;

  TaskList(
      {required this.tasks, required this.onDelete, required this.onEmailTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        String? formattedStartDate = '';
        String? formattedDueDate = '';

        if (task.BirthadayDate != null) {
          Timestamp BirthadayDate = task.BirthadayDate!;
          formattedStartDate =
              "${BirthadayDate.toDate().day.toString().padLeft(2, '0')}/${BirthadayDate.toDate().month.toString().padLeft(2, '0')}/${BirthadayDate.toDate().year.toString()}";
        }

        if (task.startDate != null) {
          Timestamp startDate = task.startDate!;
          formattedStartDate =
              "${startDate.toDate().day.toString().padLeft(2, '0')}/${startDate.toDate().month.toString().padLeft(2, '0')}/${startDate.toDate().year.toString()}";
        }

        if (task.dueDate != null) {
          Timestamp dueDate = task.dueDate!;
          formattedDueDate =
              "${dueDate.toDate().day.toString().padLeft(2, '0')}/${dueDate.toDate().month.toString().padLeft(2, '0')}/${dueDate.toDate().year.toString()}";
        }

        return Card(
          elevation: 4,
          margin: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
            title: Center(
              child: Text(
                '${task.nombre} ${task.apellido}',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 21,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                Text(
                  'Cedula: ${task.cedula}',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Edad: ${task.edad}',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fecha de Cumpleaños: $formattedStartDate',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Correo: ${task.correo}',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Genero: ${task.genero}',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Membresia: ${task.priority}',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fecha de inicio: $formattedStartDate',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fecha de fin: $formattedDueDate',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Tipo de pago: ${task.pago}',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /* IconButton(
                  icon: Icon(
                    Icons.edit_document,
                    color: Colors.purple,
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarPage(user: task),
                      ),
                    );
                    if (result != null) {
                      // Handle result from EditarPage if needed
                    }
                  },
                ),*/
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    onDelete(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.email),
                  color: Colors.blue,
                  onPressed: () {
                    onEmailTap(task.correo);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
