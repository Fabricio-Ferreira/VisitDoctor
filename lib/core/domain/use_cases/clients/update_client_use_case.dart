import 'package:dartz/dartz.dart';
import 'package:visit_doctor/app/pages/home/view_model/update_client_model_params.dart';
import 'package:visit_doctor/core/domain/use_cases/params/update_client_params.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

import '../../repositories/client_repository.dart';

class UpdateClientUseCase extends UseCase<bool, UpdateClientModelParams> {
  final ClientRepository _clientRepository;

  UpdateClientUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  @override
  Future<Either<Exception, bool>> call(UpdateClientModelParams params) async {
    final model = UpdateClientParams(
      id: params.id,
      name: params.name,
      age: params.age,
      numberHome: params.numberHome,
      referencePoint: params.referencePoint,
      hasVisit: params.hasVisit,
    );
    return _clientRepository.updateClient(model);
  }
}
