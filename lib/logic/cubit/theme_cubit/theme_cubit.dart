import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial()){
    updateAppTheme();
  }

  void updateAppTheme(){
    final Brightness currentBrightness = AppTheme.currentSystemBrightness;
    currentBrightness == Brightness.light? _setTheme(ThemeMode.light):_setTheme(ThemeMode.dark);

  }

  void _setTheme(ThemeMode themeMode){
    AppTheme.setStatusBarAndNavigationBarColors(themeMode);
    emit(state.copyWith(themeMode: themeMode));
  }

}
