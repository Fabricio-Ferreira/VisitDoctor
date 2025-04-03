import 'package:visit_doctor/core/domain/entity/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.street,
    required super.neighborhood,
    required super.city,
    required super.state,
    required super.zipCode,
    required super.complement,
    super.numberHome,
    super.referencePoint,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['logradouro'],
        neighborhood: json['bairro'],
        city: json['localidade'],
        state: json['uf'],
        zipCode: json['cep'],
        complement: json['complemento'],
      );
}
