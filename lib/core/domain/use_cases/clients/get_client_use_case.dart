import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/repositories/client_repository.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

import '../../entity/client_entity.dart';

class GetClientUseCase extends UseCase<List<ClientEntity>, String> {
  final ClientRepository _clientRepository;

  GetClientUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  @override
  Future<Either<Exception, List<ClientEntity>>> call(String params) async =>
      _clientRepository.getClient(params);
}
