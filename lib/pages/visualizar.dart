import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';
import 'package:gimnaciomusculoso/delegate/buscar.dart';
import 'package:gimnaciomusculoso/pages/editar.dart';
import 'package:gimnaciomusculoso/data/firebaseservice.dart';
import 'package:gimnaciomusculoso/pages/registrar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    _getDataFromFirestore(); // Obtener datos al cargar la página
  }

  // Método para obtener datos de Firestore
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
            icon: Icon(Icons.refresh), // Icono de recarga
            onPressed:
                _getDataFromFirestore, // Llama al método para recargar la página
          ),
          /* IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BuscarPorCedula(tasks: tasks),
              );
            },
          ),*/
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 58, 59, 52),
      body: TaskList(tasks: tasks),
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

  TaskList({required this.tasks});

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
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    // Handle delete action
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
