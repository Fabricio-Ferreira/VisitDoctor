import 'package:visit_doctor/core/data/adapters/model/address_model.dart';
import 'package:visit_doctor/core/domain/entity/client_entity.dart';

class ClientModel extends ClientEntity {
  const ClientModel({
    required super.id,
    required super.name,
    required super.age,
    required super.address,
    required super.hasVisit,
  });

  @override
  factory ClientModel.fromMap(Map<String, dynamic> map) => ClientModel(
        id: map['id'].toString(),
        name: map['name'],
        age: map['age'],
        hasVisit: map['has_visit'] == 'true',
        address: AddressModel(
          street: map['street'],
          neighborhood: map['neighborhood'],
          city: map['city'],
          state: map['uf'],
          zipCode: map['zip_code'],
          complement: map['complement'],
          numberHome: map['number_home'],
          referencePoint: map['reference_point'],
        ),
      );
}
