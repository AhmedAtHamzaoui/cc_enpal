import 'package:cc_enpal/core/error/failures.dart';
import 'package:cc_enpal/data/models/data_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class EnergyRepository {
  Future<Either<Failure, List<DataModel>>> getSolarEnergy(
      {required String date, required String type});
}
