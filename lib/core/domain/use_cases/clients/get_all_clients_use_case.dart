import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/entity/client_entity.dart';
import 'package:visit_doctor/core/domain/repositories/client_repository.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

class GetAllClientsUseCase extends UseCase<List<ClientEntity>, NoParams> {
  final ClientRepository _clientRepository;

  GetAllClientsUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  @override
  Future<Either<Exception, List<ClientEntity>>> call(NoParams params) async =>
      _clientRepository.getClients();
}
