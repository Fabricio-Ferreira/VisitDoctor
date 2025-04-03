import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;
  final String complement;
  final String? numberHome;
  final String? referencePoint;

  const AddressEntity({
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.complement,
    this.numberHome,
    this.referencePoint,
  });

  @override
  List<Object?> get props => [
        street,
        neighborhood,
        city,
        state,
        zipCode,
        complement,
        numberHome,
        referencePoint,
      ];

  AddressEntity copyWith({
    String? street,
    String? neighborhood,
    String? city,
    String? state,
    String? zipCode,
    String? complement,
    String? numberHome,
    String? referencePoint,
  }) =>
      AddressEntity(
        street: street ?? this.street,
        neighborhood: neighborhood ?? this.neighborhood,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        complement: complement ?? this.complement,
        numberHome: numberHome ?? this.numberHome,
        referencePoint: referencePoint ?? this.referencePoint,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'street': street,
        'neighborhood': neighborhood,
        'city': city,
        'uf': state,
        'zip_code': zipCode,
        'complement': complement,
        'number_home': numberHome,
        'reference_point': referencePoint,
      };

  factory AddressEntity.fromMapToDb(Map<String, dynamic> map) => AddressEntity(
        street: map['street'] as String,
        neighborhood: map['neighborhood'] as String,
        city: map['city'] as String,
        state: map['state'] as String,
        zipCode: map['zipCode'] as String,
        complement: map['complement'] as String,
        numberHome: map['number_home'] != null ? map['number_home'] as String : null,
        referencePoint: map['reference_point'] != null ? map['reference_point'] as String : null,
      );
}
