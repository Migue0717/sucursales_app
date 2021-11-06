import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sucursales_app/models/sucursal.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveSucursal(Sucursal sucursal) {
    return _db
        .collection('sucursals')
        .doc(sucursal.sucursalId)
        .set(sucursal.toMap());
  }

  Stream<List<Sucursal>> getSucursal() {
    return _db.collection('sucursals').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Sucursal.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeSucursal(String sucursalId) {
    return _db.collection('sucursals').doc(sucursalId).delete();
  }
}
