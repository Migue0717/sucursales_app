class Sucursal {
  final String sucursalId;
  final String name;
  final double phone;

  Sucursal({this.sucursalId, this.phone, this.name});

  Map<String, dynamic> toMap() {
    return {'sucursalId': sucursalId, 'name': name, 'phone': phone};
  }

  Sucursal.fromFirestore(Map<String, dynamic> firestore)
      : sucursalId = firestore['sucursalId'],
        name = firestore['name'],
        phone = firestore['phone'];
}
