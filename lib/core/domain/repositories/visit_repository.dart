import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/entity/visit_entity.dart';
import 'package:visit_doctor/core/domain/use_cases/params/visit_data_params.dart';

abstract class VisitRepository {
  Future<Either<Exception, VisitEntity>> addVisit(VisitDataParams params);
  Future<Either<Exception, List<VisitEntity>>> getVisits();
  Future<Either<Exception, bool>> removeVisit(int visitId);
  Future<Either<Exception, bool>> updateVisit(VisitDataParams params);
}
