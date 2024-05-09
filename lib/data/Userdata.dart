class UserData {
  int cedula;
  String nombre;
  String apellido;
  int edad;
  String correo;
  DateTime? BirthadayDate;
  DateTime? startDate;
  DateTime? dueDate;
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
}
