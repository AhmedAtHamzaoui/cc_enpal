import 'package:cc_enpal/core/error/failures.dart';
import 'package:cc_enpal/core/usecase/usecase.dart';
import 'package:cc_enpal/data/models/data_model.dart';
import 'package:cc_enpal/domain/repositories/energy_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetSolarEnergy implements UseCase<List<DataModel>, GetEnergyParams> {
  final EnergyRepository energyRepository;
  GetSolarEnergy(this.energyRepository);

  @override
  Future<Either<Failure, List<DataModel>>> call(GetEnergyParams params) async {
    return await energyRepository.getSolarEnergy(
        date: params.date, type: params.type);
  }
}

class GetEnergyParams {
  final String date;
  final String type;

  GetEnergyParams({
    required this.date,
    required this.type,
  });
}
