import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/use_cases/params/visit_data_params.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

import '../../entity/visit_entity.dart';
import '../../repositories/visit_repository.dart';

class CreateVisitUseCase extends UseCase<VisitEntity, VisitDataParams> {
  final VisitRepository _repository;

  CreateVisitUseCase({required VisitRepository repository}) : _repository = repository;

  @override
  Future<Either<Exception, VisitEntity>> call(VisitDataParams params) async =>
      _repository.addVisit(params);
}
