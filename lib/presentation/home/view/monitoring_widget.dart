import 'package:cc_enpal/presentation/home/bloc/monitoring_bloc.dart';
import 'package:cc_enpal/presentation/home/view/energy_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonitoringWidget extends StatelessWidget {
  final String type; // "solar", "house", "battery"
  const MonitoringWidget({super.key, required this.type});

  Future<void> _selectDate(BuildContext context) async {
    final bloc = context.read<MonitoringBloc>();
    String initialDate = bloc.getSelectedDate(type);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(initialDate),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != initialDate) {
      bloc.add(ChangeDate(
          type: type, newDate: DateFormat('yyyy-MM-dd').format(picked)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitoringBloc, MonitoringState>(
      builder: (context, state) {
        if (state is MonitoringInitial ||
            (state is MonitoringLoading && state.type == type)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MonitoringError && state.type == type) {
          return Center(child: Text("Error: ${state.message}"));
        }

        if (state is MonitoringLoaded && state.type == type) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date: ${state.date}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text("Select Date"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: EnergyChart(
                  data: state.solarEnergy,
                ),
              ),
            ],
          );
        }
        return Container(); // Fallback
      },
    );
  }
}
