/*import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';
import 'package:gimnaciomusculoso/pages/editar.dart';

class BuscarPorCedula extends SearchDelegate<List<UserData>> {
  final List<UserData> tasks;

  BuscarPorCedula({required this.tasks});

  String query = '';
  TextEditingController queryController = TextEditingController();

  @override
  String get searchFieldLabel => 'Ingrese una cédula';

  @override
  Widget buildLeading(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    query = queryController.text;
    print('Query: $query');

    final filteredTasks = tasks.where((task) =>
        task.cedula.toString().toLowerCase().contains(query.toLowerCase()));

    print('Filtered Tasks: $filteredTasks');

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        var task = filteredTasks.elementAt(index);

        String formattestardate = '';
        String formattedDueDate = '';

        if (task.startDate != null) {
          formattestardate =
              '${task.startDate!.day.toString().padLeft(2, '0')}' +
                  '/' +
                  '${task.startDate!.month.toString().padLeft(2, '0')}' +
                  '/' +
                  '${task.startDate!.year.toString()}';
        }
        if (task.dueDate != null) {
          formattedDueDate = '${task.dueDate!.day.toString().padLeft(2, '0')}' +
              '/' +
              '${task.dueDate!.month.toString().padLeft(2, '0')}' +
              '/' +
              '${task.dueDate!.year.toString()}';
        }

        return Container(
            color: Color.fromARGB(255, 70, 70, 69),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                side: BorderSide(
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
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarPage(user: task),
                            ),
                          );

                          if (result != null) {
                            task = result;
                          }
                        }),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        tasks.remove(task);
                        // Aquí puedes realizar cualquier operación adicional necesaria después de eliminar el elemento
                      },
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // Iniciar búsqueda al presionar el ícono de búsqueda
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('Ingrese una cédula para buscar',
        style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 20,
            color: Color.fromARGB(255, 0, 0, 0)));
  }
}
*/