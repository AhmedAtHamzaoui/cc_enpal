import 'package:cc_enpal/core/common/theme_bloc/theme_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(false) {
    on<SetInitialTheme>(
      (event, emit) async {
        bool hasThemeDark = await isDark();

        emit(hasThemeDark);
      },
    );

    on<ChangeTheme>(
      (event, emit) async {
        bool hasThemeDark = await isDark();

        emit(!hasThemeDark);
        setTheme(!hasThemeDark);
      },
    );
  }
}

Future<bool> isDark() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  return sharedPreferences.getBool('isDark') ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  sharedPreferences.setBool('isDark', isDark);
}