// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:sucursales_app/models/sucursal.dart';
import 'package:sucursales_app/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class SucursalProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  double _phone;
  String _sucursalId;
  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get phone => _phone;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePhone(String value) {
    _phone = double.parse(value);
    notifyListeners();
  }

  loadValues(Sucursal sucursal) {
    _name = sucursal.name;
    _phone = sucursal.phone;
    _sucursalId = sucursal.sucursalId;
  }

  saveSucursal() {
    if (_sucursalId == null) {
      var newSucursal =
          Sucursal(name: name, phone: phone, sucursalId: uuid.v4());
      firestoreService.saveSucursal(newSucursal);
    } else {
      //Update
      var updatedSucursal =
          Sucursal(name: name, phone: _phone, sucursalId: _sucursalId);
      firestoreService.saveSucursal(updatedSucursal);
    }
  }

  removeSucursal(String sucursalId) {
    firestoreService.removeSucursal(sucursalId);
  }
}
