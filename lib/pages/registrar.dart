import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/FirebaseService.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';

class RegistrarPage extends StatefulWidget {
  RegistrarPage({Key? key}) : super(key: key);

  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String? _priority;
  String? _generocontroller;
  String? _pagocontroller;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final formattedStartDate = _formatDate(picked);
      setState(() {
        _startDateController.text = formattedStartDate;
      });
      setState(() {
        _startDateTimestamp = Timestamp.fromDate(picked);
      });
    }
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final formattedDueDate = _formatDate(picked);
      setState(() {
        _dueDateController.text = formattedDueDate;
      });
      setState(() {
        _dueDateTimestamp = Timestamp.fromDate(picked);
      });
    }
  }

  Future<Null> _selectDate3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final formattedBirthday = _formatDate(picked);
      setState(() {
        _birthdayController.text = formattedBirthday;
      });
      setState(() {
        _birthdayTimestamp = Timestamp.fromDate(picked);
      });
    }
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro del cliente',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Times New Roman',
          ),
        ),
        backgroundColor: Color.fromARGB(255, 70, 70, 69),
        actions: [
          IconButton(
            onPressed: () {
              // Puedes agregar aquí la lógica para actualizar la pantalla
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 182, 182, 181),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _cedulaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cedula',
                    labelStyle: TextStyle(
                        fontFamily:
                            'Times New Roman'), // Establecer la fuente del label
                  ),
                  style: TextStyle(
                      fontFamily:
                          'Times New Roman'), // Establecer la fuente del texto ingresado
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    if (value.length > 11) {
                      return 'La cedula debe tener exactamente 10 caracteres.';
                    }
                    if (value.length < 10) {
                      return 'La cedula debe tener exactamente 10 caracteres.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(
                        fontFamily:
                            'Times New Roman'), // Establecer la fuente del label
                  ),
                  style: TextStyle(
                      fontFamily:
                          'Times New Roman'), // Establecer la fuente del texto ingresado
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    final RegExp regex = RegExp(
                      r'^[a-zA-Z]',
                    );
                    if (!regex.hasMatch(value)) {
                      return 'El nombre debe tener un formato válido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _apellidoController,
                  decoration: InputDecoration(
                    labelText: 'Apellido',
                    labelStyle: TextStyle(
                        fontFamily:
                            'Times New Roman'), // Establecer la fuente del label
                  ),
                  style: TextStyle(
                      fontFamily:
                          'Times New Roman'), // Establecer la fuente del texto ingresado
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    if (value.length > 10) {
                      return 'El Apellido debe tener un máximo de 20 caracteres.';
                    }
                    final RegExp regex = RegExp(
                      r'^[a-zA-Z]',
                    );
                    if (!regex.hasMatch(value)) {
                      return 'El apellido debe tener un formato válido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _edadController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Edad',
                    labelStyle: TextStyle(
                        fontFamily:
                            'Times New Roman'), // Establecer la fuente del label
                  ),
                  style: TextStyle(
                      fontFamily:
                          'Times New Roman'), // Establecer la fuente del texto ingresado
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    if (value.length > 2) {
                      return 'La edad debe tener un máximo de 2 caracteres.';
                    }
                    if (value.length < 2) {
                      return 'La edad debe tener un máximo de 2 caracteres.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _correoController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    labelStyle: TextStyle(
                        fontFamily:
                            'Times New Roman'), // Establecer la fuente del label
                  ),
                  style: TextStyle(
                      fontFamily:
                          'Times New Roman'), // Establecer la fuente del texto ingresado
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio.';
                    }
                    final RegExp regex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!regex.hasMatch(value)) {
                      return 'El correo debe tener un formato válido.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _generocontroller,
                  items: ['Masculino', 'Femenino', 'Otros']
                      .map((priority) => DropdownMenuItem(
                            child: Text(
                              priority,
                              style: TextStyle(fontFamily: 'Times New Roman'),
                            ),
                            value: priority,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _generocontroller = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Genero Del Cliente',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'El genero';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _birthdayController,
                  decoration: InputDecoration(
                    labelText: 'Fecha de cumpleaños (dd/mm/aaaa)',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  style: TextStyle(fontFamily: 'Times New Roman'),
                  onTap: () {
                    _selectDate3(context);
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Datos Obligatorios';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _startDateController,
                  decoration: InputDecoration(
                    labelText: 'Fecha de inicio (dd/mm/aaaa)',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  style: TextStyle(fontFamily: 'Times New Roman'),
                  onTap: () {
                    _selectDate(context);
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Datos Obligatorios';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _dueDateController,
                  decoration: InputDecoration(
                    labelText: 'Fecha de Fin (dd/mm/aaaa)',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  style: TextStyle(fontFamily: 'Times New Roman'),
                  onTap: () {
                    _selectDate2(context);
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Datos Obligatorios';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _priority,
                  items: [
                    'Normal(50,000)',
                    'Premiun(70,000)',
                    'Golden(100,000)'
                  ]
                      .map((priority) => DropdownMenuItem(
                            child: Text(
                              priority,
                              style: TextStyle(fontFamily: 'Times New Roman'),
                            ),
                            value: priority,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _priority = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Membresia',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Enter la Membresia';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _pagocontroller,
                  items: ['Efectivo', 'Tarjeta', 'Transferencia']
                      .map((priority) => DropdownMenuItem(
                            child: Text(
                              priority,
                              style: TextStyle(fontFamily: 'Times New Roman'),
                            ),
                            value: priority,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _pagocontroller = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Tipo de pago del Cliente',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontFamily: 'Times New Roman'),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Tipo de pago';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validar el formulario antes de guardar
                    if (_formKey.currentState!.validate()) {
                      // Verificar que todas las fechas y campos obligatorios estén presentes
                      if (_birthdayTimestamp != null &&
                          _startDateTimestamp != null &&
                          _dueDateTimestamp != null &&
                          _priority != null &&
                          _generocontroller != null &&
                          _pagocontroller != null) {
                        final newUserData = UserData(
                          int.parse(_cedulaController.text),
                          _nombreController.text,
                          _apellidoController.text,
                          int.parse(_edadController.text),
                          _correoController.text,
                          _birthdayTimestamp!,
                          _startDateTimestamp!,
                          _dueDateTimestamp!,
                          _priority!,
                          _generocontroller!,
                          _pagocontroller!,
                        );

                        FirebaseService.saveUserData(newUserData).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cliente guardado con éxito'),
                            ),
                          );
                          // Limpiar el formulario después de guardar
                          _formKey.currentState!.reset();
                        }).catchError((error) {
                          // Mostrar un mensaje de error si falla la operación de guardado
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Error al guardar el cliente: $error'),
                            ),
                          );
                        });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 0, 0, 0),
                    backgroundColor: Color.fromARGB(255, 21, 73, 105),
                  ),
                  child: Text(
                    'Guardar Cliente',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Timestamp? _startDateTimestamp;
  Timestamp? _dueDateTimestamp;
  Timestamp? _birthdayTimestamp;
}
