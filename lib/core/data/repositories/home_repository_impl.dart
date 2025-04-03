import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:visit_doctor/core/domain/use_cases/params/add_client_params.dart';

import '../../domain/entity/address_entity.dart';
import '../../domain/entity/client_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/local/home/home_data_source_local.dart';
import '../data_sources/remote/home/home_data_source_remote.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSourceRemote _remoteDataSource;
  final HomeDataSourceLocal _localDataSource;

  HomeRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Exception, AddressEntity>> getAddressByCep(String cep) async {
    try {
      final result = await _remoteDataSource.getAddressByCep(cep);
      return Right(result);
    } on DioException catch (e, exception) {
      return Left(Exception(exception));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, ClientEntity>> addClient(AddClientParams params) async {
    try {
      final result = await _localDataSource.addClient(params);
      return Right(result);
    } on DioException catch (e, exception) {
      return Left(Exception(exception));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
