import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';

class RegistrarPage extends StatefulWidget {
  RegistrarPage({super.key});

  @override

  // ignore: library_private_types_in_public_api
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
  final TextEditingController _BirthdayController = TextEditingController();
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
      final formattedStratdate = '${picked.day.toString().padLeft(2, '0')}' +
          '/' +
          '${picked.month.toString().padLeft(2, '0')}' +
          '/' +
          '${picked.year.toString()}';
      setState(() {
        _startDateController.text = formattedStratdate;
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
      final formattedDate = '${picked.day.toString().padLeft(2, '0')}' +
          '/' +
          '${picked.month.toString().padLeft(2, '0')}' +
          '/' +
          '${picked.year.toString()}';
      setState(() {
        _dueDateController.text = formattedDate;
      });
    }
  }

  Future<Null> _selectDate3(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2019),
    );
    if (picked != null) {
      final formattedDate = '${picked.day.toString().padLeft(2, '0')}' +
          '/' +
          '${picked.month.toString().padLeft(2, '0')}' +
          '/' +
          '${picked.year.toString()}';
      setState(() {
        _BirthdayController.text = formattedDate;
      });
    }
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
        ),
        backgroundColor: Color.fromARGB(255, 182, 182, 181),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
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
                                  style:
                                      TextStyle(fontFamily: 'Times New Roman'),
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
                      controller: _BirthdayController,
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
                                  style:
                                      TextStyle(fontFamily: 'Times New Roman'),
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
                                  style:
                                      TextStyle(fontFamily: 'Times New Roman'),
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
                        if (_formKey.currentState!.validate()) {
                          DateTime? BirthadayDate;
                          if (_BirthdayController.text.isNotEmpty) {
                            List<String> dateParts =
                                _BirthdayController.text.split('/');
                            if (dateParts.length == 3) {
                              int? day = int.tryParse(dateParts[0]);
                              int? month = int.tryParse(dateParts[1]);
                              int? year = int.tryParse(dateParts[2]);

                              if (day != null &&
                                  month != null &&
                                  year != null) {
                                BirthadayDate = DateTime(year, month, day);
                              }
                            }
                          }
                          if (_formKey.currentState!.validate()) {
                            DateTime? startdate;
                            if (_startDateController.text.isNotEmpty) {
                              List<String> dateParts =
                                  _startDateController.text.split('/');
                              if (dateParts.length == 3) {
                                int? day = int.tryParse(dateParts[0]);
                                int? month = int.tryParse(dateParts[1]);
                                int? year = int.tryParse(dateParts[2]);

                                if (day != null &&
                                    month != null &&
                                    year != null) {
                                  startdate = DateTime(year, month, day);
                                }
                              }
                            }
                            if (_formKey.currentState!.validate()) {
                              DateTime? dueDate;
                              if (_dueDateController.text.isNotEmpty) {
                                List<String> dateParts =
                                    _dueDateController.text.split('/');
                                if (dateParts.length == 3) {
                                  int? day = int.tryParse(dateParts[0]);
                                  int? month = int.tryParse(dateParts[1]);
                                  int? year = int.tryParse(dateParts[2]);

                                  if (day != null &&
                                      month != null &&
                                      year != null) {
                                    dueDate = DateTime(year, month, day);
                                  }
                                }
                              }
                              final task = UserData(
                                int.parse(_cedulaController.text),
                                _nombreController.text,
                                _apellidoController.text,
                                int.parse(_edadController.text),
                                _correoController.text,
                                BirthadayDate,
                                startdate,
                                dueDate,
                                _priority!,
                                _generocontroller!,
                                _pagocontroller!,
                              );

                              Navigator.pop(context, task);
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 21, 73, 105),
                        onPrimary: Color.fromARGB(255, 0, 0, 0),
                      ),
                      child: Text(
                        'Guardar Cliente ',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    )
                  ]))),
        ));
  }
}
