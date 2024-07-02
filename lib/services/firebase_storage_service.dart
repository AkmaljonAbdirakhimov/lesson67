import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:lesson67/firebase_options.dart';

class FirebaseStorageService {
  final _storage = FirebaseStorage.instance;

  Future<String?> uploadFile(String fileName, File file) async {
    final imageReference =
        _storage.ref().child("cars").child("images").child("$fileName.jpg");
    final uploadTask = imageReference.putFile(
      file,
    );

    uploadTask.snapshotEvents.listen((status) {
      //? faylni yuklash holati
      print(status
          .state); // running - yuklanmoqda; success - yuklandi; error - xatolik

      //? faylni yuklash foizi
      double percentage = (status.bytesTransferred / file.lengthSync()) * 100;

      print("$percentage%");
    });

    String? imageUrl;

    await uploadTask.whenComplete(() async {
      imageUrl = await imageReference.getDownloadURL();
    });

    // final ref = _carsImageStorage.refFromURL("asd"); //? rasm url'dan reference tayyorlash
    // ref.delete(); //? rasmni o'chirish

    return imageUrl;
  }

  //! with ISOLATES
  // void startUploadIsolate(String filePath) async {
  //   await FlutterIsolate.spawn(uploadFileToFirebase, filePath);
  // }

  // void uploadFileToFirebase(String filePath) async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );

  //   File file = File(filePath);
  //   try {
  //     Reference ref =
  //         FirebaseStorage.instance.ref().child('uploads/hellworld.jpg');
  //     UploadTask uploadTask = ref.putFile(file);

  //     // You can use the uploadTask to manage the upload and get a URL
  //     final snapshot = await uploadTask.whenComplete(() => {});
  //     final downloadUrl = await snapshot.ref.getDownloadURL();
  //     print('Download URL: $downloadUrl');
  //     print('Download URL: $downloadUrl');
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //   }
  // }
}
