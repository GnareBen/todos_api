part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

/// Initialise le thème depuis le stockage persistant
final class ThemeStarted extends ThemeEvent {
  const ThemeStarted();
}

/// Toggle dark <-> light
final class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}