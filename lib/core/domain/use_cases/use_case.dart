import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUseCase {
  const BaseUseCase();
}

abstract class UseCase<Type, Params> extends BaseUseCase {
  const UseCase();
  Future<Either<Exception, Type>> call(Params params);
}

abstract class BaseSimpleUseCase<Param, Result> extends BaseUseCase {
  const BaseSimpleUseCase();
  Result call(Param params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
