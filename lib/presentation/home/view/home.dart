import 'package:cc_enpal/core/common/theme_bloc/theme_bloc.dart';
import 'package:cc_enpal/core/common/theme_bloc/theme_event.dart';
import 'package:cc_enpal/init_dependencies.dart';
import 'package:cc_enpal/presentation/home/bloc/monitoring_bloc.dart';
import 'package:cc_enpal/presentation/home/view/monitoring_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
                  },
                  tabs: const [
                    Tab(icon: Icon(Icons.solar_power_rounded)),
                    Tab(icon: Icon(Icons.house_rounded)),
                    Tab(icon: Icon(Icons.battery_5_bar_rounded)),
                  ],
                ),
                title: const Text('Dashboard'),
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<MonitoringBloc>().add(ClearLocalData());
                    },
                    icon: const Text(
                      "Clear Local Data",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  BlocBuilder<ThemeBloc, bool>(builder: (context, state) {
                    return Switch(
                      value: state,
                      onChanged: (bool val) {
                        context.read<ThemeBloc>().add(ChangeTheme());
                      },
                    );
                  })
                ],
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
