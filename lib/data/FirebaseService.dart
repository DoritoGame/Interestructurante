import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  // Método para inicializar Firebase
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // Método para obtener una instancia de Firestore
  static FirebaseFirestore getFirestoreInstance() {
    return FirebaseFirestore.instance;
  }
}
