/*import 'package:flutter/material.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';
import 'package:intl/intl.dart';

class EditarPage extends StatefulWidget {
  final UserData user;

  EditarPage({required this.user});

  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  String? _priority;
  String? _generoController;
  String? _pagocontroller;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final formattedStartDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        _startDateController.text = formattedStartDate;
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
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        _dueDateController.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _cedulaController.text = widget.user.cedula.toString();
    _nombreController.text = widget.user.nombre;
    _apellidoController.text = widget.user.apellido;
    _edadController.text = widget.user.edad.toString();
    _correoController.text = widget.user.correo;
    _startDateController.text = widget.user.startDate != null
        ? DateFormat('dd/MM/yyyy').format(widget.user.startDate!)
        : '';
    _dueDateController.text = widget.user.dueDate != null
        ? DateFormat('dd/MM/yyyy').format(widget.user.dueDate!)
        : '';
    _priority = widget.user.priority;
    _generoController = widget.user.genero;
    _pagocontroller = widget.user.pago;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Cliente',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Times New Roman',
          ),
        ),
        backgroundColor: Color.fromARGB(255, 70, 70, 69),
      ),
      backgroundColor: Color.fromARGB(255, 182, 182, 181),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                      if (value.length < 7) {
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
                      if (value.length > 10) {
                        return 'El nombre debe tener un máximo de 10 caracteres.';
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
                    value: _generoController,
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
                        _generoController = value;
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
                    onPressed: ()  {
                      if (_formKey.currentState?.validate() ?? false) {
                        widget.user.cedula = int.parse(_cedulaController.text);
                        widget.user.nombre = _nombreController.text;
                        widget.user.apellido = _apellidoController.text;
                        widget.user.edad = int.parse(_edadController.text);
                        widget.user.correo = _correoController.text;
                        widget.user.startDate =
                            _startDateController.text.isNotEmpty
                                ? DateFormat('dd/MM/yyyy')
                                    .parse(_startDateController.text)
                                : DateTime.now();
                        widget.user.dueDate = _dueDateController.text.isNotEmpty
                            ? DateFormat('dd/MM/yyyy')
                                .parse(_dueDateController.text)
                            : DateTime.now();
                        widget.user.priority = _priority!;
                        widget.user.genero = _generoController!;
                        widget.user.pago = _pagocontroller!;
                        Navigator.pop(context, widget.user);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 21, 73, 105),
                      onPrimary: Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: Text(
                      'Guardar Cambios ',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Times New Roman',
                      ),
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
*/