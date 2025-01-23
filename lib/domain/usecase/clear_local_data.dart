import 'dart:async';

import 'package:cc_enpal/core/error/failures.dart';
import 'package:cc_enpal/core/usecase/usecase.dart';
import 'package:cc_enpal/domain/repositories/energy_repository.dart';
import 'package:fpdart/fpdart.dart';

class ClearLocalDataUseCase implements UseCase<Unit, NoParams> {
  final EnergyRepository energyRepository;
  ClearLocalDataUseCase(this.energyRepository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return energyRepository.clearAllLocalData();
  }
}
