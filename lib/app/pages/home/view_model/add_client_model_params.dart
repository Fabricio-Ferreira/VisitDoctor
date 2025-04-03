import 'package:visit_doctor/core/domain/entity/address_entity.dart';

class AddClientModelParams {
  final String name;
  final int age;
  final String? hasVisit;
  final AddressEntity address;

  AddClientModelParams({
    required this.name,
    required this.age,
    required this.address,
    this.hasVisit = 'false',
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'age': age,
        ...address.toMap(),
      };

  factory AddClientModelParams.fromMap(Map<String, dynamic> map) => AddClientModelParams(
        name: map['name'] as String,
        age: map['age'] as int,
        address: AddressEntity.fromMapToDb(map['address'] as Map<String, dynamic>),
      );
}
