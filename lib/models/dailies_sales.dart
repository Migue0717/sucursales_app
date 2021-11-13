class DailiesSales {
  final String sucursalId;
  final String description;
  final double quantity;
  final double netValue;
  final double grossValue;

  DailiesSales(
      {this.sucursalId,
      this.description,
      this.quantity,
      this.netValue,
      this.grossValue});

  Map<String, dynamic> toMap() {
    return {
      'sucursalId': sucursalId,
      'description': description,
      'quantity': quantity,
      'netValue': netValue,
      'grossValue': grossValue
    };
  }

  DailiesSales.fromFirestore(Map<String, dynamic> firestore)
      : sucursalId = firestore['sucursalId'],
        description = firestore['description'],
        quantity = firestore['quantity'],
        netValue = firestore['netValue'],
        grossValue = firestore['grossValue'];
}
