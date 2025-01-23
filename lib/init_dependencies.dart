import 'package:cc_enpal/core/network/connection_checker.dart';
import 'package:cc_enpal/data/datasource/local/energy_local_data_source.dart';
import 'package:cc_enpal/data/datasource/remote/energy_remote_data_source.dart';
import 'package:cc_enpal/data/repositories/energy_repository_impl.dart';
import 'package:cc_enpal/domain/repositories/energy_repository.dart';
import 'package:cc_enpal/domain/usecase/clear_local_data.dart';
import 'package:cc_enpal/domain/usecase/get_solar_energy.dart';
import 'package:cc_enpal/presentation/home/bloc/monitoring_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initHome();

  final path = (await getApplicationDocumentsDirectory()).path;
  Hive.init(path);
  // Open a box for app-wide storage
  var box = await Hive.openBox('appBox');

  // Register Hive Box as a singleton
  serviceLocator.registerSingleton<Box>(box);

  serviceLocator.registerSingleton<Dio>(Dio());

  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initHome() {
  // Datasource
  serviceLocator
    ..registerFactory<EnergyRemoteDataSource>(
      () => EnergyRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<EnergyLocalDataSource>(
      () => EnergyLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<EnergyRepository>(
      () => EnergyRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => GetSolarEnergy(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ClearLocalDataUseCase(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => MonitoringBloc(
          getSolarEnergy: serviceLocator(), clearLocalData: serviceLocator()),
    );
}
