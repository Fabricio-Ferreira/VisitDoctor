import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

import '../../entity/visit_entity.dart';
import '../../repositories/visit_repository.dart';

class GetVisitsUseCase extends UseCase<List<VisitEntity>, NoParams> {
  final VisitRepository _repository;

  GetVisitsUseCase({required VisitRepository repository}) : _repository = repository;

  @override
  Future<Either<Exception, List<VisitEntity>>> call(NoParams params) async =>
      _repository.getVisits();
}
