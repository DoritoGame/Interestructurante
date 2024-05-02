import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';
import 'package:gimnaciomusculoso/delegate/buscar.dart';
import 'package:gimnaciomusculoso/pages/bot.dart';
import 'package:gimnaciomusculoso/pages/editar.dart';
import 'package:gimnaciomusculoso/pages/registrar.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<UserData> tasks = [];

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
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BuscarPorCedula(tasks: tasks),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 58, 59, 52),
      body: TaskList(tasks: tasks),
      floatingActionButton: TextButton(
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
                  int priorityComparison = priorityA.compareTo(priorityB);
                  if (priorityComparison != 0) {
                    return priorityComparison;
                  } else {
                    if (a.dueDate == null && b.dueDate == null) {
                      return 0;
                    } else if (a.dueDate == null) {
                      return 1;
                    } else if (b.dueDate == null) {
                      return -1;
                    } else {
                      return a.dueDate!.compareTo(b.dueDate!);
                    }
                  }
                });
              });
            }
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 21, 73, 105)),
        child: Text(
          'Registrar Cliente',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Times New Roman',
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    // ignore: unused_local_variable
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }
}

class TaskList extends StatefulWidget {
  final List<UserData> tasks;

  TaskList({required this.tasks});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  void toggleTaskCompletion(UserData task) {
    setState(() {
      task.isComplete = !task.isComplete;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        var task = widget.tasks[index];
        // ignore: unused_local_variable
        String taskInfo = 'priority: ${task.priority}';
        String formattestardate = '';
        String formattedDueDate = '';

        if (task.startDate != null) {
          formattestardate =
              '${task.startDate!.day.toString().padLeft(2, '0')}' +
                  '/' +
                  '${task.startDate!.month.toString().padLeft(2, '0')}' +
                  '/' +
                  '${task.startDate!.year.toString()}';
          taskInfo += ' - Start date: $formattestardate';
        }
        if (task.dueDate != null) {
          formattedDueDate = '${task.dueDate!.day.toString().padLeft(2, '0')}' +
              '/' +
              '${task.dueDate!.month.toString().padLeft(2, '0')}' +
              '/' +
              '${task.dueDate!.year.toString()}';
          taskInfo += ' - Due date: $formattedDueDate';
        }

        final borderColor = Color.fromARGB(255, 0, 0, 0);
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ListTile(
            title: Center(
              child: Text(
                'Cliente',
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
                  'Cedula: ',
                  style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20,
                      color: Color.fromARGB(255, 80, 80, 72)),
                ),
                SizedBox(height: 6),
                Text(
                  task.cedula.toString(),
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Nombre: ',
                  style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20,
                      color: Color.fromARGB(255, 80, 80, 72)),
                ),
                SizedBox(height: 6),
                Text(
                  task.nombre,
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Apellido: ',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.apellido,
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Edad: ',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.edad.toString(),
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Correo: ',
                  style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20,
                      color: Color.fromARGB(255, 80, 80, 72)),
                ),
                SizedBox(height: 6),
                Text(
                  task.correo,
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Genero:',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.genero,
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Membresia: ',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.priority,
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fecha de inicio date:',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  formattestardate,
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Fecha de fin:',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  formattedDueDate,
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Tipo de pago: ',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20,
                    color: Color.fromARGB(255, 80, 80, 72),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  task.pago,
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
                IconButton(
                  icon: Icon(
                    Icons.edit_document,
                    color: Colors.purple,
                  ),
                  onPressed: () async {
                    // Abre la página de edición y espera el resultado
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarPage(user: task),
                      ),
                    );

                    // Actualiza la tarea en la lista si se guardaron cambios
                    if (result != null) {
                      setState(() {
                        task = result;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.purple,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.tasks.remove(task);
                    });
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
