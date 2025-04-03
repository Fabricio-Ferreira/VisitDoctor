import 'package:dartz/dartz.dart';
import 'package:visit_doctor/app/pages/home/view_model/add_client_model_params.dart';
import 'package:visit_doctor/core/domain/use_cases/params/add_client_params.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

import '../../entity/client_entity.dart';
import '../../repositories/home_repository.dart';

class AddClientUseCase extends UseCase<ClientEntity, AddClientModelParams> {
  final HomeRepository _homeRepository;

  AddClientUseCase({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  @override
  Future<Either<Exception, ClientEntity>> call(AddClientModelParams params) async {
    final model = AddClientParams(
      name: params.name,
      age: params.age,
      address: params.address,
    );
    return _homeRepository.addClient(model);
  }
}
