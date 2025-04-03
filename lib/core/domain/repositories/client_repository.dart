import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/entity/client_entity.dart';

import '../use_cases/params/update_client_params.dart';

abstract class ClientRepository {
  Future<Either<Exception, bool>> deleteClient(String clientId);
  Future<Either<Exception, List<ClientEntity>>> getClient(String text);
  Future<Either<Exception, List<ClientEntity>>> getClients();
  Future<Either<Exception, bool>> updateClient(UpdateClientParams params);
}
