import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/repositories/client_repository.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

class DeleteClientUseCase extends UseCase<bool, String> {
  final ClientRepository _clientRepository;

  DeleteClientUseCase({required ClientRepository clientRepository})
      : _clientRepository = clientRepository;

  @override
  Future<Either<Exception, bool>> call(String params) async =>
      _clientRepository.deleteClient(params);
}
