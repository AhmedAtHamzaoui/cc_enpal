part of 'monitoring_bloc.dart';

abstract class MonitoringEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMonitoringData extends MonitoringEvent {
  final String type; // "solar", "house", "battery"
  final String date;

  FetchMonitoringData({required this.type, required this.date});

  @override
  List<Object> get props => [type];
}

class ChangeDate extends MonitoringEvent {
  final String type;
  final String newDate;

  ChangeDate({required this.type, required this.newDate});

  @override
  List<Object> get props => [type, newDate];
}

class ClearLocalData extends MonitoringEvent {
  ClearLocalData();

  @override
  List<Object> get props => [];
}
