import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sucursales_app/models/dailies_sales.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDailies(DailiesSales dailies) {
    return _db.collection('dailies').doc().set(dailies.toMap());
  }

  Stream<List<DailiesSales>> getDailies() {
    return _db.collection('dailies').snapshots().map((snapshot) => snapshot.docs
        .map((document) => DailiesSales.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeDailies(String sucursalId) {
    return _db.collection('dailies').doc(sucursalId).delete();
  }
}
