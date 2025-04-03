import 'package:equatable/equatable.dart';

import 'package:visit_doctor/core/domain/entity/address_entity.dart';

class ClientEntity extends Equatable {
  final String id;
  final String name;
  final int age;
  final AddressEntity address;
  final bool hasVisit;

  const ClientEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.address,
    this.hasVisit = false,
  });

  @override
  List<Object> get props => [
        id,
        name,
        age,
        address,
        hasVisit,
      ];

  ClientEntity copyWith({
    String? id,
    String? name,
    int? age,
    AddressEntity? address,
    bool? hasVisit,
  }) =>
      ClientEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        address: address ?? this.address,
        hasVisit: hasVisit ?? this.hasVisit,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'age': age,
        'address': address.toMap(),
      };

  factory ClientEntity.fromMap(Map<String, dynamic> map) => ClientEntity(
        id: map['id'] as String,
        name: map['name'] as String,
        age: map['age'] as int,
        address: AddressEntity.fromMapToDb(map['address'] as Map<String, dynamic>),
      );
}
