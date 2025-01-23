import 'package:cc_enpal/data/models/data_model.dart';
import 'package:cc_enpal/domain/usecase/get_solar_energy.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'monitoring_event.dart';
part 'monitoring_state.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  final GetSolarEnergy _getSolarEnergy;
  final Map<String, String> _selectedDates = {
    "solar": DateFormat('yyyy-MM-dd').format(DateTime.now()),
    "house": DateFormat('yyyy-MM-dd').format(DateTime.now()),
    "battery": DateFormat('yyyy-MM-dd').format(DateTime.now()),
  };

  MonitoringBloc({required GetSolarEnergy getSolarEnergy})
      : _getSolarEnergy = getSolarEnergy,
        super(MonitoringInitial()) {
    on<FetchMonitoringData>(_onFetchSolarEnergy);
    on<ChangeDate>(_onChangeDate);
  }

  void _onFetchSolarEnergy(
    FetchMonitoringData event,
    Emitter<MonitoringState> emit,
  ) async {
    _selectedDates[event.type] = event.date; // Update selected date
    emit(MonitoringLoading(type: event.type, date: event.date));
    final res = await _getSolarEnergy(GetEnergyParams(
      date: event.date,
      type: event.type,
    ));
    res.fold(
      (l) => emit(MonitoringError(
          type: event.type, date: event.date, message: l.message)),
      (r) => emit(
          MonitoringLoaded(type: event.type, date: event.date, solarEnergy: r)),
    );
  }

  void _onChangeDate(
    ChangeDate event,
    Emitter<MonitoringState> emit,
  ) async {
    _selectedDates[event.type] = event.newDate; // Update selected date
    add(FetchMonitoringData(type: event.type, date: event.newDate));
  }

  String getSelectedDate(String type) => _selectedDates[type]!;
}
