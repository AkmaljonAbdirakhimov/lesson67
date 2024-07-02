import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lesson67/services/firebase_storage_service.dart';

class CarsFirebaseService {
  final _carsCollection = FirebaseFirestore.instance.collection("cars");
  final _firebaseStorageService = FirebaseStorageService();

  Stream<QuerySnapshot> getCars() async* {
    yield* _carsCollection.snapshots();
  }

  Future<void> addCar(String name, File imageFile) async {
    try {
      final imageUrl =
          await _firebaseStorageService.uploadFile(name, imageFile);

      await _carsCollection.add({
        "name": name,
        "imageUrl": imageUrl,
      });
    } catch (e) {
      print(e);
    }
  }
}
