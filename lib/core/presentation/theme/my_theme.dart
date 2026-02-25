import 'package:flutter/material.dart';

/// Palette de couleurs personnalisée pour l'app Todo.
abstract final class AppColors {
  // Indigo (seed color)
  static const seed = Color(0xFF3F51B5);

  // Accents
  static const success = Color(0xFF4CAF50);
  static const successLight = Color(0xFFC8E6C9);
  static const warning = Color(0xFFFF9800);
  static const warningLight = Color(0xFFFFE0B2);
  static const error = Color(0xFFE53935);

  // Surfaces sombres
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E2E);
  static const darkCard = Color(0xFF252535);
}

abstract final class MyTheme {
  // ---------------------------------------------------------------------------
  // Thème CLAIR
  // ---------------------------------------------------------------------------
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.light,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),

      // Cards (TodoCard)
      cardTheme: CardThemeData(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colorScheme.surfaceContainerLowest,
      ),

      // Boutons principaux (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Chips (statut todo)
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),

      // Icônes
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),

      // Dividers
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
      ),

      // Texte
      textTheme: _buildTextTheme(colorScheme.onSurface),
    );
  }

  // ---------------------------------------------------------------------------
  // Thème SOMBRE
  // ---------------------------------------------------------------------------
  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.dark,
      surface: AppColors.darkSurface,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),

      // Cards (TodoCard)
      cardTheme: CardThemeData(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: AppColors.darkCard,
      ),

      // Boutons principaux (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      // Chips (statut todo)
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),

      // Icônes
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),

      // Dividers
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
      ),

      // Texte
      textTheme: _buildTextTheme(colorScheme.onSurface),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers privés
  // ---------------------------------------------------------------------------

  /// Construit une [TextTheme] cohérente avec la couleur de texte principale.
  static TextTheme _buildTextTheme(Color baseColor) {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: baseColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: baseColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: baseColor.withAlpha(100),
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: baseColor.withAlpha(100),
      ),
    );
  }
}
