import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/repositories/visit_repository.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

class DeleteVisitUseCase extends UseCase<bool, int> {
  final VisitRepository _repository;

  DeleteVisitUseCase({required VisitRepository repository}) : _repository = repository;

  @override
  Future<Either<Exception, bool>> call(int params) async => _repository.removeVisit(params);
}
