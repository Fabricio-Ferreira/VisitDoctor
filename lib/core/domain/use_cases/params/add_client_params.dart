import 'package:visit_doctor/core/domain/entity/address_entity.dart';

class AddClientParams {
  final String name;
  final int age;
  final AddressEntity address;

  AddClientParams({
    required this.name,
    required this.age,
    required this.address,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'age': age,
        ...address.toMap(),
      };

  factory AddClientParams.fromMap(Map<String, dynamic> map) => AddClientParams(
        name: map['name'] as String,
        age: map['age'] as int,
        address: AddressEntity.fromMapToDb(map['address'] as Map<String, dynamic>),
      );
}
