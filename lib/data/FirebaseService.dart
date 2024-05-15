import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gimnaciomusculoso/data/Userdata.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class FirebaseService {
  static Future<void> deleteUserDataByCedula(int cedula) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('clientes')
          .where('cedula', isEqualTo: cedula)
          .get();

      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      print("Usuario(s) eliminado(s) con éxito");
    } catch (error) {
      print("Error al eliminar el usuario: $error");
      throw error;
    }
  }

  static Future<void> saveUserData(UserData userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('clientes')
          .add(userData.toMap());
      print("Cliente guardado con éxito");
    } catch (error) {
      print("Error al guardar el cliente: $error");
      throw error;
    }
  }

  static Future<List<UserData>> getAllUserData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('clientes').get();

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
      print("Error retrieving data from Firestore: $error");
      throw error;
    }
  }

  static Future<void> sendEmailNotification(
      String email, String notificationType) async {
    final smtpServer =
        gmail('gimnaciomusculoso@gmail.com', 'btfs fubg yofc hxec');

    String subject;
    String body;

    switch (notificationType) {
      case 'Notification De Pago':
        subject = '¡Notificación de Pago Pendiente!';
        body = '''
  ¡Hola!

  Querido miembro,

  En Musculoso Gym nos preocupamos por tu bienestar y queremos mantenerte al tanto de las últimas novedades y eventos emocionantes que tenemos para ti. Aquí tienes algunos mensajes importantes:

    **Pago Oportuno Mensual:**
     Te recordamos que tienes un pago pendiente por tu membresía en Musculoso Gym. Por favor, asegúrate de realizar tu pago a la brevedad para evitar la suspensión de tu membresía.

  ¡Esperamos verte pronto en el gimnasio!

  ¡Mantente fuerte y motivado!

  Atentamente,
  El Equipo de Musculoso Gym
  '''
            '';
        break;
      case 'Notification De Ofertas Especiales':
        subject = '¡No te pierdas nuestras Ofertas Especiales!';
        body = '''
  ¡Hola!

  Querido miembro,

  En Musculoso Gym nos preocupamos por tu bienestar y queremos mantenerte al tanto de las últimas novedades y eventos emocionantes que tenemos para ti. Aquí tienes algunos mensajes importantes:

    **Oferta Especial del Mes:**
     Este mes, estamos ofreciendo un descuento del 20% en todos nuestros paquetes de entrenamiento personal. ¡Aprovecha esta oportunidad para trabajar en tus metas de fitness de manera más personalizada!

  ¡Esperamos verte pronto en el gimnasio!

  ¡Mantente fuerte y motivado!

  Atentamente,
  El Equipo de Musculoso Gym
  '''
            '';
        break;
      case 'Notification De Actualizacion De Horarios':
        subject = '¡Actualización de Horarios!';
        body = '''
  ¡Hola!

  Querido miembro,

  En Musculoso Gym nos preocupamos por tu bienestar y queremos mantenerte al tanto de las últimas novedades y eventos emocionantes que tenemos para ti. Aquí tienes algunos mensajes importantes:

    **Terminos de Horarios Actualizados**
    Te informamos que hemos realizado algunas actualizaciones en nuestro horario de clases y de apertura. Por favor, revisa nuestra página web o comunícate con nosotros para obtener los detalles más recientes.


  ¡Esperamos verte pronto en el gimnasio!

  ¡Mantente fuerte y motivado!

  Atentamente,
  El Equipo de Musculoso Gym
  '''
            '';
        break;
      default:
        throw ArgumentError(
            'Tipo de notificación no válido: $notificationType');
    }

    final message = Message()
      ..from = Address(
          'gimnaciomusculoso@gmail.com', 'Servicios Del Gimnacio Musculoso')
      ..recipients.add(email)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error sending email: $e');
      throw e;
    }
  }
}
