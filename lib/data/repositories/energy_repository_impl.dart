import 'package:cc_enpal/core/error/exceptions.dart';
import 'package:cc_enpal/core/error/failures.dart';
import 'package:cc_enpal/core/network/connection_checker.dart';
import 'package:cc_enpal/data/datasource/remote/energy_remote_data_source.dart';
import 'package:cc_enpal/data/models/data_model.dart';
import 'package:cc_enpal/domain/repositories/energy_repository.dart';
import 'package:fpdart/fpdart.dart';

class EnergyRepositoryImpl implements EnergyRepository {
  final EnergyRemoteDataSource energyRemoteDataSource;
  final ConnectionChecker connectionChecker;

  EnergyRepositoryImpl(this.energyRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, List<DataModel>>> getSolarEnergy(
      {required String date, required String type}) async {
    try {
      final data_energy =
          await energyRemoteDataSource.getSolarEnergy(date, type);
      //blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(data_energy);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
