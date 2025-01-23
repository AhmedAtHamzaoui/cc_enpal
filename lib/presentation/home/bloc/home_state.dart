part of 'home_bloc.dart';


@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}


final class SolarEnergySuccess extends HomeState {
  final List<DataModel> solarEnergy;
  SolarEnergySuccess(this.solarEnergy);
}
