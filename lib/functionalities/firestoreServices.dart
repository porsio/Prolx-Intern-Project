import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<QuerySnapshot> getCategories() {
    return db.collection('categories').orderBy('index').snapshots();
  }

  Stream<QuerySnapshot> getFeaturedProducts() {
    return db
        .collection('products')
        .where("isFeatured", isEqualTo: true)
        .snapshots();
  }
}
