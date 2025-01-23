import 'package:cc_enpal/core/usecase/usecase.dart';
import 'package:cc_enpal/data/models/data_model.dart';
import 'package:cc_enpal/domain/usecase/get_solar_energy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetSolarEnergy _getSolarEnergy;

  HomeBloc({required GetSolarEnergy getSolarEnergy})
      : _getSolarEnergy = getSolarEnergy,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoading()));
    on<HomeFetchSolarEnergy>(_onFetchSolarEnergy);
  }

  void _onFetchSolarEnergy(
    HomeFetchSolarEnergy event,
    Emitter<HomeState> emit,
  ) async {
    print("date: ${event.date}");
    final res = await _getSolarEnergy(GetEnergyParams(
      date: event.date,
      type: 'solar',
    ));
    res.fold(
      (l) => emit(HomeFailure(l.message)),
      (r) => emit(SolarEnergySuccess(r)),
    );
  }
}
