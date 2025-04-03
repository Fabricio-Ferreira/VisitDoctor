import 'package:dartz/dartz.dart';
import 'package:visit_doctor/core/domain/use_cases/use_case.dart';

import '../../entity/address_entity.dart';
import '../../repositories/home_repository.dart';

class GetAddressByCepUseCase extends UseCase<AddressEntity, String> {
  final HomeRepository repository;
  const GetAddressByCepUseCase(
    this.repository,
  );

  @override
  Future<Either<Exception, AddressEntity>> call(String params) async =>
      repository.getAddressByCep(params);
}
