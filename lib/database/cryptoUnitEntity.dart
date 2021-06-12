import 'package:floor/floor.dart';

@entity
class CryptoUnit {
  @primaryKey
  late String id;
  late double value;
  late double quantity;

  CryptoUnit({required this.id, required this.value, required this.quantity});

  factory CryptoUnit.fromJson(Map<String, dynamic> parsedJson) {
    return new CryptoUnit(
        id: parsedJson['id'],
        value: parsedJson['value'],
        quantity: parsedJson['quantity']);
  }

  Map<String, dynamic> toJson() {
    return {"id": this.id, "value": this.value, "quantity": this.quantity};
  }
}
