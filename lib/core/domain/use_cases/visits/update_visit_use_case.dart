import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/use_cases/params/visit_data_params.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

import '../../repositories/visit_repository.dart';

class UpdateVisitUseCase extends UseCase<bool, VisitDataParams> {
  final VisitRepository _repository;

  UpdateVisitUseCase({required VisitRepository repository}) : _repository = repository;

  @override
  Future<Either<Exception, bool>> call(VisitDataParams params) async =>
      _repository.updateVisit(params);
}
