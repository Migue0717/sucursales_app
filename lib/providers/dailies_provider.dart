// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:sucursales_app/models/dailies_sales.dart';
import 'package:sucursales_app/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class DailiesProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  var uuid = Uuid();
  String _sucursalId;
  String _description;
  double _quantity;
  double _netValue;
  double _grossValue;

  //Getters
  String get description => _description;
  double get quantity => _quantity;
  double get netValue => _netValue;
  double get grossValue => _grossValue;

  //Setters
  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  changeQuantity(String value) {
    _quantity = double.parse(value);
    notifyListeners();
  }

  changeNetValue(String value) {
    _netValue = double.parse(value);
    notifyListeners();
  }

  changeGrossValue(String value) {
    _grossValue = double.parse(value);
    notifyListeners();
  }

  loadValues(DailiesSales dailiesSales) {
    _sucursalId = dailiesSales.sucursalId;
    _description = dailiesSales.description;
    _netValue = dailiesSales.netValue;
    _grossValue = dailiesSales.grossValue;
  }

  saveDailies() {
    if (_sucursalId == null) {
      var newDailies = DailiesSales(
          sucursalId: uuid.v4(),
          description: _description,
          quantity: _quantity,
          netValue: _netValue,
          grossValue: _grossValue);
      firestoreService.saveDailies(newDailies);
    } else {
      //Update
      var updatedDailies = DailiesSales(
          sucursalId: _sucursalId,
          description: _description,
          quantity: _quantity,
          netValue: _netValue,
          grossValue: _grossValue);
      firestoreService.saveDailies(updatedDailies);
    }
  }

  removeDailies(String sucursalId) {
    firestoreService.removeDailies(sucursalId);
  }
}
