import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  int cedula;
  String nombre;
  String apellido;
  int edad;
  String correo;
  Timestamp? BirthadayDate;
  Timestamp? startDate;
  Timestamp? dueDate;
  String priority;
  String genero;
  String pago;
  bool isComplete;

  UserData(
    this.cedula,
    this.nombre,
    this.apellido,
    this.edad,
    this.correo,
    this.BirthadayDate,
    this.startDate,
    this.dueDate,
    this.priority,
    this.genero,
    this.pago, {
    this.isComplete = false,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      json['cedula']as int,
      json['nombre'],
      json['apellido'],
      json['edad'],
      json['correo'],
      json['BirthadayDate'] != null ? json['BirthadayDate'] : null,
      json['startDate'] != null ? json['startDate'] : null,
      json['dueDate'] != null ? json['dueDate'] : null,
      json['priority'],
      json['genero'],
      json['pago'],
      isComplete: json['isComplete'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'edad': edad,
      'correo': correo,
      'BirthadayDate': BirthadayDate,
      'startDate': startDate,
      'dueDate': dueDate,
      'priority': priority,
      'genero': genero,
      'pago': pago,
      'isComplete': isComplete,
    };
  }
}
