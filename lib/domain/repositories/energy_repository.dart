import 'package:cc_enpal/core/error/failures.dart';
import 'package:cc_enpal/domain/entities/data.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EnergyRepository {
  Future<Either<Failure, List<Data>>> getSolarEnergy(
      {required String date, required String type});

  Either<Failure, Unit> clearAllLocalData();
}
