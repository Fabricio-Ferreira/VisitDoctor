import 'package:visit_doctor/core/data/adapters/model/address_model.dart';

abstract class HomeDataSourceRemote {
  Future<AddressModel> getAddressByCep(String cep);
}
