import 'package:cc_enpal/core/error/exceptions.dart';
import 'package:cc_enpal/core/error/failures.dart';
import 'package:cc_enpal/core/network/connection_checker.dart';
import 'package:cc_enpal/data/datasource/local/energy_local_data_source.dart';
import 'package:cc_enpal/data/datasource/remote/energy_remote_data_source.dart';
import 'package:cc_enpal/data/models/data_model.dart';
import 'package:cc_enpal/domain/repositories/energy_repository.dart';
import 'package:fpdart/fpdart.dart';

class EnergyRepositoryImpl implements EnergyRepository {
  final EnergyRemoteDataSource energyRemoteDataSource;
  final EnergyLocalDataSource energyLocalDataSource;
  final ConnectionChecker connectionChecker;

  EnergyRepositoryImpl(this.energyRemoteDataSource, this.energyLocalDataSource,
      this.connectionChecker);

  @override
  Future<Either<Failure, List<DataModel>>> getSolarEnergy(
      {required String date, required String type}) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure('No internet connection'));
      }
      if (energyLocalDataSource.loadData(type: type, date: date).isNotEmpty) {
        return right(energyLocalDataSource.loadData(type: type, date: date));
      }
      final dataEnergy =
          await energyRemoteDataSource.getSolarEnergy(date, type);
      energyLocalDataSource.uploadLocalData(
          type: type, date: date, data: dataEnergy);
      return right(dataEnergy);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Either<Failure, Unit> clearAllLocalData() {
    try {
      energyLocalDataSource.clearAllData();
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
