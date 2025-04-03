import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/use_cases/params/add_client_params.dart';

import '../entity/address_entity.dart';
import '../entity/client_entity.dart';

abstract class HomeRepository {
  Future<Either<Exception, AddressEntity>> getAddressByCep(String cep);
  Future<Either<Exception, ClientEntity>> addClient(AddClientParams params);
}
