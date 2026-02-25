part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

final class ThemeLoaded extends ThemeState {
  final ThemeMode themeMode;

  const ThemeLoaded({required this.themeMode});

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  List<Object> get props => [themeMode];
}