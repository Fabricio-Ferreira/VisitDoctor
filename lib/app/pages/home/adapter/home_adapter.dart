import 'package:visit_doctor/app/pages/home/view_model/home_view_model.dart';
import 'package:visit_doctor/core/domain/entity/address_entity.dart';

class HomeAdapter {
  HomeAdapter._();

  static HomeViewModel toViewModel(AddressEntity address) => HomeViewModel(
        street: address.street,
        neighborhood: address.neighborhood,
        city: address.city,
        state: address.state,
      );
}
