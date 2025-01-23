import 'package:cc_enpal/core/common/widgets/loader.dart';
import 'package:cc_enpal/core/utils/show_snackbar.dart';
import 'package:cc_enpal/init_dependencies.dart';
import 'package:cc_enpal/presentation/home/bloc/home_bloc.dart';
import 'package:cc_enpal/presentation/home/bloc/monitoring_bloc.dart';
import 'package:cc_enpal/presentation/home/view/energy_chart.dart';
import 'package:cc_enpal/presentation/home/view/monitoring_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/* class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeFetchSolarEnergy(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now())));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.solar_power_rounded)),
                  Tab(icon: Icon(Icons.house_rounded)),
                  Tab(icon: Icon(Icons.battery_5_bar_rounded)),
                ],
              ),
              title: const Text('Dashboard'),
            ),
            body: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
              if (state is HomeFailure) {
                showSnackBar(context, state.error);
              }
            }, builder: (context, state) {
              if (state is HomeLoading) {
                return const Loader();
              }
              if (state is SolarEnergySuccess) {
            
                return TabBarView(
                  children: [
                    EnergyChart(
                      data: state.solarEnergy,
                      homeBloc: context.read<HomeBloc>(),
                    ),
                    const Icon(Icons.directions_transit),
                    const Icon(Icons.directions_bike),
                  ],
                );
              }
              return const SizedBox();
            })));
  }
}
 */

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<MonitoringBloc>()
        ..add(FetchMonitoringData(
            type: "solar",
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()))),
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  onTap: (value) {
                    String type = value == 0
                        ? "solar"
                        : value == 1
                            ? "house"
                            : "battery";

                    String selectedDate =
                        context.read<MonitoringBloc>().getSelectedDate(type);
                    context.read<MonitoringBloc>().add(
                        FetchMonitoringData(type: type, date: selectedDate));
                    /* if (value == 0) {
                      context
                          .read<MonitoringBloc>()
                          .add(FetchMonitoringData("solar"));
                    } else if (value == 1) {
                      context
                          .read<MonitoringBloc>()
                          .add(FetchMonitoringData("house"));
                    } else if (value == 2) {
                      context
                          .read<MonitoringBloc>()
                          .add(FetchMonitoringData("battery"));
                    } */
                  },
                  tabs: const [
                    Tab(icon: Icon(Icons.solar_power_rounded)),
                    Tab(icon: Icon(Icons.house_rounded)),
                    Tab(icon: Icon(Icons.battery_5_bar_rounded)),
                  ],
                ),
                title: const Text('Dashboard'),
              ),
              body: const TabBarView(
                children: [
                  MonitoringWidget(type: "solar"),
                  MonitoringWidget(type: "house"),
                  MonitoringWidget(type: "battery"),
                ],
              ))),
    );
  }
}
