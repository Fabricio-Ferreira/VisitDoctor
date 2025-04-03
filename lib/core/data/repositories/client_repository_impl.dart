import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/use_cases/params/update_client_params.dart';

import '../../domain/entity/client_entity.dart';
import '../../domain/repositories/client_repository.dart';
import '../data_sources/local/client/client_data_source_local.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientDataSourceLocal _localDataSource;

  ClientRepositoryImpl({required ClientDataSourceLocal localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Either<Exception, bool>> deleteClient(String clientId) async {
    try {
      final result = await _localDataSource.deleteClient(clientId);
      if (result > 0) {
        return const Right(true);
      } else {
        return Left(Exception('Error deleting client'));
      }
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<ClientEntity>>> getClient(String text) async {
    try {
      final result = await _localDataSource.getClient(text);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<ClientEntity>>> getClients() async {
    try {
      final result = await _localDataSource.getClients();
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> updateClient(UpdateClientParams params) async {
    try {
      final result = await _localDataSource.updateClient(params);
      if (result > 0) {
        return const Right(true);
      } else {
        return Left(Exception('Error update client'));
      }
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
