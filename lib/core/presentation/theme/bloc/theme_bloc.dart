import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

const _kThemeKey = 'app_theme_is_dark';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences _prefs;

  ThemeBloc({required SharedPreferences prefs})
      : _prefs = prefs,
        super(const ThemeInitial()) {
    on<ThemeStarted>(_onThemeStarted);
    on<ThemeToggled>(_onThemeToggled);
  }

  /// Rehydrate le thème depuis SharedPreferences au démarrage
  Future<void> _onThemeStarted(
    ThemeStarted event,
    Emitter<ThemeState> emit,
  ) async {
    final isDark = _prefs.getBool(_kThemeKey) ?? false;
    emit(ThemeLoaded(
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
    ));
  }

  /// Toggle et persiste immédiatement le nouveau thème
  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final current = state;
    if (current is! ThemeLoaded) return;

    final isDark = current.themeMode == ThemeMode.dark;
    final nextMode = isDark ? ThemeMode.light : ThemeMode.dark;

    await _prefs.setBool(_kThemeKey, !isDark);
    emit(ThemeLoaded(themeMode: nextMode));
  }
}