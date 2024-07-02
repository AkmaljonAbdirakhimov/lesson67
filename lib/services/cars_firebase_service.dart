import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CarsFirebaseService {
  final _carsCollection = FirebaseFirestore.instance.collection("cars");
  final _carsImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getCars() async* {
    yield* _carsCollection.snapshots();
  }

  Future<void> addCar(String name, File imageFile) async {
    final imageReference = _carsImageStorage
        .ref()
        .child("cars")
        .child("images")
        .child("$name.jpg");
    final uploadTask = imageReference.putFile(
      imageFile,
    );

    uploadTask.snapshotEvents.listen((status) {
      //? faylni yuklash holati
      print(status
          .state); // running - yuklanmoqda; success - yuklandi; error - xatolik

      //? faylni yuklash foizi
      double percentage =
          (status.bytesTransferred / imageFile.lengthSync()) * 100;

      print("$percentage%");
    });

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();
      await _carsCollection.add({
        "name": name,
        "imageUrl": imageUrl,
      });
    });

    // final ref = _carsImageStorage.refFromURL("asd"); //? rasm url'dan reference tayyorlash
    // ref.delete(); //? rasmni o'chirish
  }
}
