import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/entity/visit_entity.dart';
import 'package:visit_doctor/core/domain/repositories/visit_repository.dart';
import 'package:visit_doctor/core/domain/use_cases/params/visit_data_params.dart';

import '../data_sources/local/visit/visit_data_source_local.dart';

class VisitRepositoryImpl implements VisitRepository {
  final VisitDataSourceLocal _localDataSource;

  VisitRepositoryImpl({required VisitDataSourceLocal localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Either<Exception, VisitEntity>> addVisit(VisitDataParams params) async {
    try {
      final result = await _localDataSource.createVisit(params);

      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<VisitEntity>>> getVisits() async {
    try {
      final result = await _localDataSource.getVisits();
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> removeVisit(int visitId) async {
    try {
      final result = await _localDataSource.deleteVisit(visitId);
      if (result > 0) {
        return const Right(true);
      } else {
        return Left(Exception('Error deleting visit'));
      }
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> updateVisit(VisitDataParams params) async {
    try {
      final result = await _localDataSource.updateVisit(params);
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
