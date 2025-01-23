import 'package:cc_enpal/core/common/theme/app_theme.dart';
import 'package:cc_enpal/core/common/theme/colors.dart';
import 'package:cc_enpal/core/common/theme_bloc/theme_bloc.dart';
import 'package:cc_enpal/core/common/theme_bloc/theme_event.dart';
import 'package:cc_enpal/init_dependencies.dart';
import 'package:cc_enpal/presentation/home/bloc/monitoring_bloc.dart';
import 'package:cc_enpal/presentation/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<MonitoringBloc>()),
      BlocProvider(create: (_) => ThemeBloc()..add(SetInitialTheme()))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Enpal challenge',
        theme: state
            ? AppTheme(AppColors.darkColors).getTheme()
            : AppTheme(AppColors.mainColors).getTheme(),
        home: const HomePage(),
      );
    });
  }
}
