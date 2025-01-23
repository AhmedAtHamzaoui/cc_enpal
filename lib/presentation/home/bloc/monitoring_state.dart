part of 'monitoring_bloc.dart';

abstract class MonitoringState extends Equatable {
  @override
  List<Object> get props => [];
}

class MonitoringInitial extends MonitoringState {}

class MonitoringLoading extends MonitoringState {
  final String type;
  final String date;

  MonitoringLoading({required this.type, required this.date});

  @override
  List<Object> get props => [type, date];
}

class MonitoringLoaded extends MonitoringState {
  final String type;
  final String date;
  final List<DataModel> solarEnergy;

  MonitoringLoaded(
      {required this.type, required this.date, required this.solarEnergy});

  @override
  List<Object> get props => [type, date, solarEnergy];
}

class MonitoringError extends MonitoringState {
  final String type;
  final String date;
  final String message;

  MonitoringError(
      {required this.type, required this.date, required this.message});

  @override
  List<Object> get props => [type, date, message];
}
