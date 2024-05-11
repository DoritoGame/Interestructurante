import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';

class FirebaseService {
  static Future<void> saveUserData(UserData userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('clientes') // Nombre de la colección en Firestore
          .add(userData
              .toMap()); // Convierte los datos del cliente a un mapa y los agrega a Firestore
      print("Cliente guardado con éxito");
    } catch (error) {
      print("Error al guardar el cliente: $error");
      throw error; // Relanzar el error para que sea manejado en el nivel superior
    }
  }

  static Future<List<UserData>> getAllUserData() async {
    try {
      // Obtener la colección 'clientes' de Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('clientes').get();

      // Mapear los documentos obtenidos a objetos UserData
      List<UserData> userDataList = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserData(
          data['cedula'],
          data['nombre'],
          data['apellido'],
          data['edad'],
          data['correo'],
          data['BirthadayDate'],
          data['startDate'],
          data['dueDate'],
          data['priority'],
          data['genero'],
          data['pago'],
          isComplete: data['isComplete'] ?? false,
        );
      }).toList();

      return userDataList;
    } catch (error) {
      // Manejar errores en caso de que la operación falle
      print("Error retrieving data from Firestore: $error");
      throw error; // Relanzar el error para que sea manejado en el nivel superior
    }
  }
}
