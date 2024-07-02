import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  final String id;
  String name;
  String imageUrl;

  Car({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Car.fromQuerySnapshot(QueryDocumentSnapshot query) {
    return Car(
      id: query.id,
      name: query['name'],
      imageUrl: query['imageUrl'],
    );
  }
}
