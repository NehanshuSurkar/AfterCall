// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppSpacing {
//   // Spacing values
//   static const double xs = 4.0;
//   static const double sm = 8.0;
//   static const double md = 16.0;
//   static const double lg = 24.0;
//   static const double xl = 32.0;
//   static const double xxl = 48.0;

//   // Edge insets shortcuts
//   static const EdgeInsets paddingXs = EdgeInsets.all(xs);
//   static const EdgeInsets paddingSm = EdgeInsets.all(sm);
//   static const EdgeInsets paddingMd = EdgeInsets.all(md);
//   static const EdgeInsets paddingLg = EdgeInsets.all(lg);
//   static const EdgeInsets paddingXl = EdgeInsets.all(xl);

//   // Horizontal padding
//   static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
//   static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
//   static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
//   static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
//   static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);

//   // Vertical padding
//   static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
//   static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
//   static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
//   static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
//   static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
// }

// /// Border radius constants for consistent rounded corners
// class AppRadius {
//   static const double sm = 8.0;
//   static const double md = 12.0;
//   static const double lg = 16.0;
//   static const double xl = 24.0;
// }

// // =============================================================================
// // TEXT STYLE EXTENSIONS
// // =============================================================================

// /// Extension to add text style utilities to BuildContext
// /// Access via context.textStyles
// extension TextStyleContext on BuildContext {
//   TextTheme get textStyles => Theme.of(this).textTheme;
// }

// /// Helper methods for common text style modifications
// extension TextStyleExtensions on TextStyle {
//   /// Make text bold
//   TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

//   /// Make text semi-bold
//   TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

//   /// Make text medium weight
//   TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

//   /// Make text normal weight
//   TextStyle get normal => copyWith(fontWeight: FontWeight.w400);

//   /// Make text light
//   TextStyle get light => copyWith(fontWeight: FontWeight.w300);

//   /// Add custom color
//   TextStyle withColor(Color color) => copyWith(color: color);

//   /// Add custom size
//   TextStyle withSize(double size) => copyWith(fontSize: size);
// }

// // =============================================================================
// // COLORS
// // =============================================================================

// /// Calm, professional color palette for AfterCall light mode
// class LightModeColors {
//   // Primary: Soft teal for calm, trustworthy feel
//   static const lightPrimary = Color(0xFF4A9B9F);
//   static const lightOnPrimary = Color(0xFFFFFFFF);
//   static const lightPrimaryContainer = Color(0xFFD0EFEF);
//   static const lightOnPrimaryContainer = Color(0xFF00363A);

//   // Secondary: Warm sand for approachable warmth
//   static const lightSecondary = Color(0xFFE8D5C4);
//   static const lightOnSecondary = Color(0xFF4A3C2E);

//   // Tertiary: Coral accent for CTAs
//   static const lightTertiary = Color(0xFFE07A5F);
//   static const lightOnTertiary = Color(0xFFFFFFFF);

//   // Error colors
//   static const lightError = Color(0xFFD84545);
//   static const lightOnError = Color(0xFFFFFFFF);
//   static const lightErrorContainer = Color(0xFFFFE6E6);
//   static const lightOnErrorContainer = Color(0xFF5C1919);

//   // Surface and background: Off-white for calm reading
//   static const lightSurface = Color(0xFFFFFFFF);
//   static const lightOnSurface = Color(0xFF2C3E50);
//   static const lightBackground = Color(0xFFF7F7F5);
//   static const lightSurfaceVariant = Color(0xFFF0F0EE);
//   static const lightOnSurfaceVariant = Color(0xFF5A6370);

//   // Outline and shadow
//   static const lightOutline = Color(0xFFD0D0CE);
//   static const lightShadow = Color(0xFF000000);
//   static const lightInversePrimary = Color(0xFF7BBEC2);
// }

// /// Dark mode colors with calm aesthetic
// class DarkModeColors {
//   // Primary: Lighter teal for dark background
//   static const darkPrimary = Color(0xFF7BBEC2);
//   static const darkOnPrimary = Color(0xFF00363A);
//   static const darkPrimaryContainer = Color(0xFF2E7478);
//   static const darkOnPrimaryContainer = Color(0xFFD0EFEF);

//   // Secondary
//   static const darkSecondary = Color(0xFFD4BCA8);
//   static const darkOnSecondary = Color(0xFF4A3C2E);

//   // Tertiary
//   static const darkTertiary = Color(0xFFE89B84);
//   static const darkOnTertiary = Color(0xFF5C2E1F);

//   // Error colors
//   static const darkError = Color(0xFFFF9B9B);
//   static const darkOnError = Color(0xFF5C1919);
//   static const darkErrorContainer = Color(0xFFA63030);
//   static const darkOnErrorContainer = Color(0xFFFFE6E6);

//   // Surface and background: Deep charcoal
//   static const darkSurface = Color(0xFF1C2128);
//   static const darkOnSurface = Color(0xFFE5E9EC);
//   static const darkSurfaceVariant = Color(0xFF2A3340);
//   static const darkOnSurfaceVariant = Color(0xFFC4C9D1);

//   // Outline and shadow
//   static const darkOutline = Color(0xFF4A5158);
//   static const darkShadow = Color(0xFF000000);
//   static const darkInversePrimary = Color(0xFF4A9B9F);
// }

// /// Font size constants
// class FontSizes {
//   static const double displayLarge = 57.0;
//   static const double displayMedium = 45.0;
//   static const double displaySmall = 36.0;
//   static const double headlineLarge = 32.0;
//   static const double headlineMedium = 28.0;
//   static const double headlineSmall = 24.0;
//   static const double titleLarge = 22.0;
//   static const double titleMedium = 16.0;
//   static const double titleSmall = 14.0;
//   static const double labelLarge = 14.0;
//   static const double labelMedium = 12.0;
//   static const double labelSmall = 11.0;
//   static const double bodyLarge = 16.0;
//   static const double bodyMedium = 14.0;
//   static const double bodySmall = 12.0;
// }

// // =============================================================================
// // THEMES
// // =============================================================================

// /// Light theme with modern, neutral aesthetic
// ThemeData get lightTheme => ThemeData(
//   useMaterial3: true,
//   splashFactory: NoSplash.splashFactory,
//   colorScheme: ColorScheme.light(
//     primary: LightModeColors.lightPrimary,
//     onPrimary: LightModeColors.lightOnPrimary,
//     primaryContainer: LightModeColors.lightPrimaryContainer,
//     onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
//     secondary: LightModeColors.lightSecondary,
//     onSecondary: LightModeColors.lightOnSecondary,
//     tertiary: LightModeColors.lightTertiary,
//     onTertiary: LightModeColors.lightOnTertiary,
//     error: LightModeColors.lightError,
//     onError: LightModeColors.lightOnError,
//     errorContainer: LightModeColors.lightErrorContainer,
//     onErrorContainer: LightModeColors.lightOnErrorContainer,
//     surface: LightModeColors.lightSurface,
//     onSurface: LightModeColors.lightOnSurface,
//     surfaceContainerHighest: LightModeColors.lightSurfaceVariant,
//     onSurfaceVariant: LightModeColors.lightOnSurfaceVariant,
//     outline: LightModeColors.lightOutline,
//     shadow: LightModeColors.lightShadow,
//     inversePrimary: LightModeColors.lightInversePrimary,
//   ),
//   brightness: Brightness.light,
//   scaffoldBackgroundColor: LightModeColors.lightBackground,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.transparent,
//     foregroundColor: LightModeColors.lightOnSurface,
//     elevation: 0,
//     scrolledUnderElevation: 0,
//   ),
//   cardTheme: CardThemeData(
//     elevation: 0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//       side: BorderSide(
//         color: LightModeColors.lightOutline.withValues(alpha: 0.2),
//         width: 1,
//       ),
//     ),
//   ),
//   filledButtonTheme: FilledButtonThemeData(
//     style: ButtonStyle(
//       padding: const WidgetStatePropertyAll(
//         EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       ),
//       shape: WidgetStatePropertyAll(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.lg),
//         ),
//       ),
//       backgroundColor: WidgetStateProperty.resolveWith((states) {
//         final c = LightModeColors.lightTertiary;
//         if (states.contains(WidgetState.pressed))
//           return c.withValues(alpha: 0.9);
//         if (states.contains(WidgetState.hovered))
//           return c.withValues(alpha: 0.95);
//         return c;
//       }),
//       foregroundColor: const WidgetStatePropertyAll(
//         LightModeColors.lightOnTertiary,
//       ),
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       elevation: const WidgetStatePropertyAll(0),
//     ),
//   ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: ButtonStyle(
//       padding: const WidgetStatePropertyAll(
//         EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       ),
//       shape: WidgetStatePropertyAll(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.lg),
//         ),
//       ),
//       side: WidgetStateProperty.resolveWith((states) {
//         final color = LightModeColors.lightOutline.withValues(alpha: 0.5);
//         return BorderSide(color: color, width: 1.2);
//       }),
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       foregroundColor: WidgetStatePropertyAll(LightModeColors.lightPrimary),
//     ),
//   ),
//   iconButtonTheme: IconButtonThemeData(
//     style: ButtonStyle(
//       iconColor: WidgetStatePropertyAll(LightModeColors.lightOnSurface),
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       shape: WidgetStatePropertyAll(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.md),
//         ),
//       ),
//     ),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     fillColor: LightModeColors.lightSurface,
//     border: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: LightModeColors.lightOutline.withValues(alpha: 0.35),
//       ),
//       borderRadius: BorderRadius.circular(AppRadius.md),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: LightModeColors.lightPrimary),
//       borderRadius: BorderRadius.circular(AppRadius.md),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: LightModeColors.lightOutline.withValues(alpha: 0.35),
//       ),
//       borderRadius: BorderRadius.circular(AppRadius.md),
//     ),
//     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//   ),
//   dialogTheme: DialogThemeData(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(AppRadius.lg),
//     ),
//     backgroundColor: LightModeColors.lightSurface,
//     elevation: 0,
//   ),
//   dividerTheme: DividerThemeData(
//     color: LightModeColors.lightOutline.withValues(alpha: 0.2),
//     thickness: 1,
//   ),
//   sliderTheme: SliderThemeData(
//     activeTrackColor: LightModeColors.lightPrimary,
//     inactiveTrackColor: LightModeColors.lightOutline.withValues(alpha: 0.3),
//     thumbColor: LightModeColors.lightPrimary,
//     overlayColor: LightModeColors.lightPrimary.withValues(alpha: 0.1),
//   ),
//   textTheme: _buildTextTheme(Brightness.light),
// );

// /// Dark theme with good contrast and readability
// ThemeData get darkTheme => ThemeData(
//   useMaterial3: true,
//   splashFactory: NoSplash.splashFactory,
//   colorScheme: ColorScheme.dark(
//     primary: DarkModeColors.darkPrimary,
//     onPrimary: DarkModeColors.darkOnPrimary,
//     primaryContainer: DarkModeColors.darkPrimaryContainer,
//     onPrimaryContainer: DarkModeColors.darkOnPrimaryContainer,
//     secondary: DarkModeColors.darkSecondary,
//     onSecondary: DarkModeColors.darkOnSecondary,
//     tertiary: DarkModeColors.darkTertiary,
//     onTertiary: DarkModeColors.darkOnTertiary,
//     error: DarkModeColors.darkError,
//     onError: DarkModeColors.darkOnError,
//     errorContainer: DarkModeColors.darkErrorContainer,
//     onErrorContainer: DarkModeColors.darkOnErrorContainer,
//     surface: DarkModeColors.darkSurface,
//     onSurface: DarkModeColors.darkOnSurface,
//     surfaceContainerHighest: DarkModeColors.darkSurfaceVariant,
//     onSurfaceVariant: DarkModeColors.darkOnSurfaceVariant,
//     outline: DarkModeColors.darkOutline,
//     shadow: DarkModeColors.darkShadow,
//     inversePrimary: DarkModeColors.darkInversePrimary,
//   ),
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: DarkModeColors.darkSurface,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.transparent,
//     foregroundColor: DarkModeColors.darkOnSurface,
//     elevation: 0,
//     scrolledUnderElevation: 0,
//   ),
//   cardTheme: CardThemeData(
//     elevation: 0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//       side: BorderSide(
//         color: DarkModeColors.darkOutline.withValues(alpha: 0.2),
//         width: 1,
//       ),
//     ),
//   ),
//   filledButtonTheme: FilledButtonThemeData(
//     style: ButtonStyle(
//       padding: const WidgetStatePropertyAll(
//         EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       ),
//       shape: WidgetStatePropertyAll(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.lg),
//         ),
//       ),
//       backgroundColor: WidgetStateProperty.resolveWith((states) {
//         final c = DarkModeColors.darkTertiary;
//         if (states.contains(WidgetState.pressed))
//           return c.withValues(alpha: 0.95);
//         if (states.contains(WidgetState.hovered))
//           return c.withValues(alpha: 0.98);
//         return c;
//       }),
//       foregroundColor: const WidgetStatePropertyAll(
//         DarkModeColors.darkOnTertiary,
//       ),
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       elevation: const WidgetStatePropertyAll(0),
//     ),
//   ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: ButtonStyle(
//       padding: const WidgetStatePropertyAll(
//         EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       ),
//       shape: WidgetStatePropertyAll(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.lg),
//         ),
//       ),
//       side: WidgetStateProperty.resolveWith((states) {
//         final color = DarkModeColors.darkOutline.withValues(alpha: 0.6);
//         return BorderSide(color: color, width: 1.2);
//       }),
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       foregroundColor: const WidgetStatePropertyAll(
//         DarkModeColors.darkOnSurface,
//       ),
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//     style: ButtonStyle(
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       foregroundColor: WidgetStatePropertyAll(DarkModeColors.darkPrimary),
//     ),
//   ),
//   iconButtonTheme: IconButtonThemeData(
//     style: ButtonStyle(
//       iconColor: WidgetStatePropertyAll(DarkModeColors.darkOnSurface),
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       shape: WidgetStatePropertyAll(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.md),
//         ),
//       ),
//     ),
//   ),
//   inputDecorationTheme: InputDecorationTheme(
//     filled: true,
//     fillColor: DarkModeColors.darkSurfaceVariant,
//     border: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: DarkModeColors.darkOutline.withValues(alpha: 0.4),
//       ),
//       borderRadius: BorderRadius.circular(AppRadius.md),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(color: DarkModeColors.darkPrimary),
//       borderRadius: BorderRadius.circular(AppRadius.md),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: DarkModeColors.darkOutline.withValues(alpha: 0.4),
//       ),
//       borderRadius: BorderRadius.circular(AppRadius.md),
//     ),
//     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//   ),
//   dialogTheme: DialogThemeData(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(AppRadius.lg),
//     ),
//     backgroundColor: DarkModeColors.darkSurface,
//     elevation: 0,
//   ),
//   dividerTheme: DividerThemeData(
//     color: DarkModeColors.darkOutline.withValues(alpha: 0.3),
//     thickness: 1,
//   ),
//   sliderTheme: SliderThemeData(
//     activeTrackColor: DarkModeColors.darkPrimary,
//     inactiveTrackColor: DarkModeColors.darkOutline.withValues(alpha: 0.4),
//     thumbColor: DarkModeColors.darkPrimary,
//     overlayColor: DarkModeColors.darkPrimary.withValues(alpha: 0.1),
//   ),
//   textTheme: _buildTextTheme(Brightness.dark),
// );

// /// Build text theme using Inter font family
// TextTheme _buildTextTheme(Brightness brightness) {
//   return TextTheme(
//     displayLarge: GoogleFonts.inter(
//       fontSize: FontSizes.displayLarge,
//       fontWeight: FontWeight.w400,
//       letterSpacing: -0.25,
//     ),
//     displayMedium: GoogleFonts.inter(
//       fontSize: FontSizes.displayMedium,
//       fontWeight: FontWeight.w400,
//     ),
//     displaySmall: GoogleFonts.inter(
//       fontSize: FontSizes.displaySmall,
//       fontWeight: FontWeight.w400,
//     ),
//     headlineLarge: GoogleFonts.inter(
//       fontSize: FontSizes.headlineLarge,
//       fontWeight: FontWeight.w600,
//       letterSpacing: -0.5,
//     ),
//     headlineMedium: GoogleFonts.inter(
//       fontSize: FontSizes.headlineMedium,
//       fontWeight: FontWeight.w600,
//     ),
//     headlineSmall: GoogleFonts.inter(
//       fontSize: FontSizes.headlineSmall,
//       fontWeight: FontWeight.w600,
//     ),
//     titleLarge: GoogleFonts.inter(
//       fontSize: FontSizes.titleLarge,
//       fontWeight: FontWeight.w600,
//     ),
//     titleMedium: GoogleFonts.inter(
//       fontSize: FontSizes.titleMedium,
//       fontWeight: FontWeight.w500,
//     ),
//     titleSmall: GoogleFonts.inter(
//       fontSize: FontSizes.titleSmall,
//       fontWeight: FontWeight.w500,
//     ),
//     labelLarge: GoogleFonts.inter(
//       fontSize: FontSizes.labelLarge,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.1,
//     ),
//     labelMedium: GoogleFonts.inter(
//       fontSize: FontSizes.labelMedium,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.5,
//     ),
//     labelSmall: GoogleFonts.inter(
//       fontSize: FontSizes.labelSmall,
//       fontWeight: FontWeight.w500,
//       letterSpacing: 0.5,
//     ),
//     bodyLarge: GoogleFonts.inter(
//       fontSize: FontSizes.bodyLarge,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.15,
//     ),
//     bodyMedium: GoogleFonts.inter(
//       fontSize: FontSizes.bodyMedium,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.25,
//     ),
//     bodySmall: GoogleFonts.inter(
//       fontSize: FontSizes.bodySmall,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 0.4,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// SPACING SYSTEM
// =============================================================================
class AppSpacing {
  // 8-point grid system
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Edge insets shortcuts
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingXxl = EdgeInsets.all(xxl);

  // Horizontal padding
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);
  static const EdgeInsets horizontalXxl = EdgeInsets.symmetric(horizontal: xxl);

  // Vertical padding
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
  static const EdgeInsets verticalXxl = EdgeInsets.symmetric(vertical: xxl);
}

// =============================================================================
// BORDER RADIUS
// =============================================================================
class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 28.0;
  static const double circle = 999.0;
}

// =============================================================================
// SHADOWS & ELEVATION
// =============================================================================
class AppShadows {
  static const List<BoxShadow> subtle = [
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 1), blurRadius: 2),
  ];

  static const List<BoxShadow> base = [
    BoxShadow(color: Color(0x14000000), offset: Offset(0, 1), blurRadius: 3),
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 1), blurRadius: 2),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> large = [
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x4D000000),
      offset: Offset(0, 20),
      blurRadius: 25,
      spreadRadius: -5,
    ),
  ];

  static const List<BoxShadow> glowPrimary = [
    BoxShadow(
      color: Color(0x406A9B9F),
      offset: Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> glowTertiary = [
    BoxShadow(
      color: Color(0x40E07A5F),
      offset: Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];
}

// =============================================================================
// GRADIENTS
// =============================================================================
class AppGradients {
  // Primary gradients
  static const Gradient primary = LinearGradient(
    colors: [Color(0xFF4A9B9F), Color(0xFF5AB2B6)],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient primaryReversed = LinearGradient(
    colors: [Color(0xFF5AB2B6), Color(0xFF4A9B9F)],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient primaryVertical = LinearGradient(
    colors: [Color(0xFF4A9B9F), Color(0xFF3A8B8F)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Surface gradients
  static const Gradient surface = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient surfaceDark = LinearGradient(
    colors: [Color(0xFF2A3340), Color(0xFF1C2128)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Card gradients
  static const Gradient cardLight = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFFCFCFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient cardDark = LinearGradient(
    colors: [Color(0xFF2A3340), Color(0xFF232A35)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Accent gradients
  static const Gradient accent = LinearGradient(
    colors: [Color(0xFFE07A5F), Color(0xFFE89B84)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient success = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Glass morphism
  static const Gradient glass = LinearGradient(
    colors: [Color(0x20FFFFFF), Color(0x10FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient glassDark = LinearGradient(
    colors: [Color(0x20FFFFFF), Color(0x05FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// =============================================================================
// COLORS - ENHANCED
// =============================================================================
class AppColors {
  // Primary - Modern Teal
  static const Color primary = Color(0xFF4A9B9F);
  static const Color primaryLight = Color(0xFF7BBEC2);
  static const Color primaryDark = Color(0xFF2E7478);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary - Warm Sand
  static const Color secondary = Color(0xFFE8D5C4);
  static const Color secondaryLight = Color(0xFFF4EAE1);
  static const Color secondaryDark = Color(0xFFD4BCA8);
  static const Color onSecondary = Color(0xFF4A3C2E);

  // Tertiary - Coral Accent
  static const Color tertiary = Color(0xFFE07A5F);
  static const Color tertiaryLight = Color(0xFFE89B84);
  static const Color tertiaryDark = Color(0xFFC85A3F);
  static const Color onTertiary = Color(0xFFFFFFFF);

  // Neutral
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDim = Color(0xFFF7F7F5);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF8F9FA);
  static const Color surfaceContainer = Color(0xFFF0F0EE);
  static const Color surfaceContainerHigh = Color(0xFFEAEAE8);
  static const Color surfaceContainerHighest = Color(0xFFE4E4E2);

  static const Color onSurface = Color(0xFF2C3E50);
  static const Color onSurfaceVariant = Color(0xFF5A6370);
  static const Color outline = Color(0xFFD0D0CE);
  static const Color outlineVariant = Color(0xFFE4E4E2);

  // Dark Mode
  static const Color surfaceDark = Color(0xFF1C2128);
  static const Color surfaceDimDark = Color(0xFF14181F);
  static const Color surfaceBrightDark = Color(0xFF2A3340);
  static const Color surfaceContainerLowestDark = Color(0xFF0F1319);
  static const Color surfaceContainerLowDark = Color(0xFF1C2128);
  static const Color surfaceContainerDark = Color(0xFF2A3340);
  static const Color surfaceContainerHighDark = Color(0xFF35404E);
  static const Color surfaceContainerHighestDark = Color(0xFF404B5A);

  static const Color onSurfaceDark = Color(0xFFE5E9EC);
  static const Color onSurfaceVariantDark = Color(0xFFC4C9D1);
  static const Color outlineDark = Color(0xFF4A5158);
  static const Color outlineVariantDark = Color(0xFF5A6370);

  // Semantic
  static const Color success = Color(0xFF4CAF50);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color successContainer = Color(0xFFE8F5E9);

  static const Color warning = Color(0xFFFF9800);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color warningContainer = Color(0xFFFFF3E0);

  static const Color error = Color(0xFFF44336);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFEBEE);

  static const Color info = Color(0xFF2196F3);
  static const Color onInfo = Color(0xFFFFFFFF);
  static const Color infoContainer = Color(0xFFE3F2FD);

  // Glass Morphism
  static const Color glassWhite = Color(0x20FFFFFF);
  static const Color glassWhiteDark = Color(0x10FFFFFF);
  static const Color glassBlack = Color(0x10000000);
  static const Color glassBlackDark = Color(0x20000000);
}

// =============================================================================
// TYPOGRAPHY - ENHANCED
// =============================================================================
class AppTypography {
  // Font Families
  static const String primaryFont = 'Inter';
  static const String accentFont = 'SF Pro Display'; // Premium feel

  // Font Sizes
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 11.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
  static const double caption = 11.0;

  // Line Heights
  static const double tight = 1.1;
  static const double snug = 1.25;
  static const double normal = 1.5;
  static const double relaxed = 1.75;
  static const double loose = 2.0;

  // Letter Spacing
  static const double letterSpacingTighter = -0.05;
  static const double letterSpacingTight = -0.025;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.025;
  static const double letterSpacingWider = 0.05;
  static const double letterSpacingWidest = 0.1;
}

// =============================================================================
// TEXT STYLE EXTENSIONS
// =============================================================================
extension TextStyleContext on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
}

extension TextStyleExtensions on TextStyle {
  TextStyle get display => copyWith(fontWeight: FontWeight.w700, height: 1.1);
  TextStyle get heading => copyWith(fontWeight: FontWeight.w600, height: 1.2);
  TextStyle get title => copyWith(fontWeight: FontWeight.w500, height: 1.3);
  TextStyle get body => copyWith(fontWeight: FontWeight.w400, height: 1.5);
  TextStyle get caption =>
      copyWith(fontWeight: FontWeight.w400, height: 1.4, fontSize: 12);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
  TextStyle withHeight(double height) => copyWith(height: height);
  TextStyle withLetterSpacing(double spacing) =>
      copyWith(letterSpacing: spacing);
}

// =============================================================================
// CUSTOM WIDGET STYLES
// =============================================================================
class AppStyles {
  // Glassmorphism Card
  // static BoxDecoration glassCard({bool dark = false}) => BoxDecoration(
  //   borderRadius: BorderRadius.circular(AppRadius.lg),
  //   gradient: dark ? AppGradients.glassDark : AppGradients.glass,
  //   border: Border.all(
  //     color: dark ? AppColors.glassWhiteDark : AppColors.glassWhite,
  //     width: 1,
  //   ),
  //   boxShadow: dark ? AppShadows.large : AppShadows.medium,
  // );
  // In AppStyles class:
  static BoxDecoration glassCard({bool dark = false}) => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    gradient:
        dark
            ? LinearGradient(
              colors: [Color(0x30FFFFFF), Color(0x10FFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
            : LinearGradient(
              colors: [
                Colors.white.withOpacity(0.95),
                Colors.white.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
    border: Border.all(
      color:
          dark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.3),
      width: 1,
    ),
    boxShadow:
        dark
            ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: -5,
                offset: Offset(0, 10),
              ),
            ]
            : [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                spreadRadius: -5,
                offset: Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
  );
  // Elevated Card
  static BoxDecoration elevatedCard({bool dark = false}) => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    gradient: dark ? AppGradients.cardDark : AppGradients.cardLight,
    boxShadow: dark ? AppShadows.large : AppShadows.medium,
    border: Border.all(
      color:
          dark
              ? AppColors.outlineDark.withOpacity(0.1)
              : AppColors.outline.withOpacity(0.1),
      width: 1,
    ),
  );

  // Primary Gradient Button
  static BoxDecoration primaryGradientButton({bool isPressed = false}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: AppGradients.primary,
        boxShadow: isPressed ? AppShadows.base : AppShadows.glowPrimary,
      );

  // Accent Gradient Button
  static BoxDecoration accentGradientButton({bool isPressed = false}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: AppGradients.accent,
        boxShadow: isPressed ? AppShadows.base : AppShadows.glowTertiary,
      );

  // Subtle Border
  static BoxDecoration subtleBorder({
    bool dark = false,
    double radius = AppRadius.md,
  }) => BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color:
          dark
              ? AppColors.outlineDark.withOpacity(0.2)
              : AppColors.outline.withOpacity(0.2),
      width: 1,
    ),
  );
}

// =============================================================================
// ANIMATIONS
// =============================================================================
class AppAnimations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration base = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve spring = Curves.elasticOut;
  static const Curve bounce = Curves.bounceOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
}

// =============================================================================
// THEME DATA - ENHANCED
// =============================================================================
ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  splashFactory: NoSplash.splashFactory,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.error,
    background: AppColors.surfaceDim,
    onBackground: AppColors.onSurface,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceVariant: AppColors.surfaceContainer,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    shadow: Colors.black12,
    scrim: Colors.black26,
    inverseSurface: AppColors.surfaceDark,
    onInverseSurface: AppColors.onSurfaceDark,
    inversePrimary: AppColors.primaryLight,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.surfaceDim,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.onSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: GoogleFonts.inter(
      fontSize: AppTypography.titleLarge,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
    ),
    toolbarHeight: 64,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
    ),
    color: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.outline;
        }
        if (states.contains(WidgetState.pressed)) {
          return AppColors.primaryDark;
        }
        return AppColors.primary;
      }),
      foregroundColor: const WidgetStatePropertyAll(AppColors.onPrimary),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
          letterSpacing: AppTypography.letterSpacingWide,
        ),
      ),
      minimumSize: const WidgetStatePropertyAll(Size(120, 48)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.outline;
        if (states.contains(WidgetState.pressed)) return AppColors.tertiaryDark;
        return AppColors.tertiary;
      }),
      foregroundColor: const WidgetStatePropertyAll(AppColors.onTertiary),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
          letterSpacing: AppTypography.letterSpacingWide,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md - 2,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        final color =
            states.contains(WidgetState.disabled)
                ? AppColors.outline
                : AppColors.primary;
        return BorderSide(color: color, width: 1.5);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.outline;
        return AppColors.primary;
      }),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
          letterSpacing: AppTypography.letterSpacingWide,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(AppSpacing.paddingSm),
      foregroundColor: WidgetStatePropertyAll(AppColors.primary),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.outline.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.outline.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    labelStyle: GoogleFonts.inter(
      color: AppColors.onSurfaceVariant,
      fontSize: AppTypography.bodyMedium,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: GoogleFonts.inter(
      color: AppColors.onSurfaceVariant.withOpacity(0.6),
      fontSize: AppTypography.bodyMedium,
      fontWeight: FontWeight.w400,
    ),
    floatingLabelStyle: GoogleFonts.inter(
      color: AppColors.primary,
      fontSize: AppTypography.labelSmall,
      fontWeight: FontWeight.w600,
    ),
  ),
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
    backgroundColor: AppColors.surface,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: GoogleFonts.inter(
      fontSize: AppTypography.titleLarge,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
    ),
    contentTextStyle: GoogleFonts.inter(
      fontSize: AppTypography.bodyMedium,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceVariant,
    ),
  ),
  dividerTheme: DividerThemeData(
    color: AppColors.outline.withOpacity(0.2),
    thickness: 1,
    space: 0,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.outline.withOpacity(0.3),
    thumbColor: AppColors.primary,
    overlayColor: AppColors.primary.withOpacity(0.1),
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    valueIndicatorTextStyle: GoogleFonts.inter(
      color: AppColors.onPrimary,
      fontSize: AppTypography.labelSmall,
      fontWeight: FontWeight.w500,
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceContainer,
    disabledColor: AppColors.surfaceContainer,
    selectedColor: AppColors.primary,
    secondarySelectedColor: AppColors.primary,
    labelStyle: GoogleFonts.inter(
      color: AppColors.onSurfaceVariant,
      fontSize: AppTypography.labelMedium,
      fontWeight: FontWeight.w500,
    ),
    secondaryLabelStyle: GoogleFonts.inter(
      color: AppColors.onPrimary,
      fontSize: AppTypography.labelMedium,
      fontWeight: FontWeight.w500,
    ),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.circle),
    ),
    side: BorderSide.none,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
  ),
  textTheme: _buildTextTheme(Brightness.light),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  splashFactory: NoSplash.splashFactory,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryLight,
    onPrimary: AppColors.primaryDark,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.onSecondary,
    tertiary: AppColors.tertiaryLight,
    onTertiary: AppColors.tertiaryDark,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.error,
    background: AppColors.surfaceDimDark,
    onBackground: AppColors.onSurfaceDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
    surfaceVariant: AppColors.surfaceContainerDark,
    onSurfaceVariant: AppColors.onSurfaceVariantDark,
    outline: AppColors.outlineDark,
    outlineVariant: AppColors.outlineVariantDark,
    shadow: Colors.black,
    scrim: Colors.black54,
    inverseSurface: AppColors.surface,
    onInverseSurface: AppColors.onSurface,
    inversePrimary: AppColors.primary,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.surfaceDimDark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.onSurfaceDark,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: GoogleFonts.inter(
      fontSize: AppTypography.titleLarge,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceDark,
    ),
    toolbarHeight: 64,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
    ),
    color: AppColors.surfaceContainerDark,
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return AppColors.outlineDark;
        }
        if (states.contains(WidgetState.pressed)) {
          return AppColors.primaryDark;
        }
        return AppColors.primaryLight;
      }),
      foregroundColor: const WidgetStatePropertyAll(AppColors.primaryDark),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
          letterSpacing: AppTypography.letterSpacingWide,
        ),
      ),
      minimumSize: const WidgetStatePropertyAll(Size(120, 48)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.outlineDark;
        if (states.contains(WidgetState.pressed)) return AppColors.tertiaryDark;
        return AppColors.tertiaryLight;
      }),
      foregroundColor: const WidgetStatePropertyAll(AppColors.tertiaryDark),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
          letterSpacing: AppTypography.letterSpacingWide,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md - 2,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      side: WidgetStateProperty.resolveWith((states) {
        final color =
            states.contains(WidgetState.disabled)
                ? AppColors.outlineDark
                : AppColors.primaryLight;
        return BorderSide(color: color, width: 1.5);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return AppColors.outlineDark;
        return AppColors.primaryLight;
      }),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
          letterSpacing: AppTypography.letterSpacingWider,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: const WidgetStatePropertyAll(AppSpacing.paddingSm),
      foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(
          fontSize: AppTypography.labelLarge,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceContainerDark,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.outlineDark.withOpacity(0.4)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.outlineDark.withOpacity(0.4)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    labelStyle: GoogleFonts.inter(
      color: AppColors.onSurfaceVariantDark,
      fontSize: AppTypography.bodyMedium,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: GoogleFonts.inter(
      color: AppColors.onSurfaceVariantDark.withOpacity(0.6),
      fontSize: AppTypography.bodyMedium,
      fontWeight: FontWeight.w400,
    ),
    floatingLabelStyle: GoogleFonts.inter(
      color: AppColors.primaryLight,
      fontSize: AppTypography.labelSmall,
      fontWeight: FontWeight.w600,
    ),
  ),
  dialogTheme: DialogThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
    backgroundColor: AppColors.surfaceContainerDark,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: GoogleFonts.inter(
      fontSize: AppTypography.titleLarge,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceDark,
    ),
    contentTextStyle: GoogleFonts.inter(
      fontSize: AppTypography.bodyMedium,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceVariantDark,
    ),
  ),
  dividerTheme: DividerThemeData(
    color: AppColors.outlineDark.withOpacity(0.3),
    thickness: 1,
    space: 0,
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.primaryLight,
    inactiveTrackColor: AppColors.outlineDark.withOpacity(0.4),
    thumbColor: AppColors.primaryLight,
    overlayColor: AppColors.primaryLight.withOpacity(0.1),
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    valueIndicatorTextStyle: GoogleFonts.inter(
      color: AppColors.primaryDark,
      fontSize: AppTypography.labelSmall,
      fontWeight: FontWeight.w500,
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceContainerHighDark,
    disabledColor: AppColors.surfaceContainerHighDark,
    selectedColor: AppColors.primaryLight,
    secondarySelectedColor: AppColors.primaryLight,
    labelStyle: GoogleFonts.inter(
      color: AppColors.onSurfaceVariantDark,
      fontSize: AppTypography.labelMedium,
      fontWeight: FontWeight.w500,
    ),
    secondaryLabelStyle: GoogleFonts.inter(
      color: AppColors.primaryDark,
      fontSize: AppTypography.labelMedium,
      fontWeight: FontWeight.w500,
    ),
    brightness: Brightness.dark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.circle),
    ),
    side: BorderSide.none,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
  ),
  textTheme: _buildTextTheme(Brightness.dark),
);

TextTheme _buildTextTheme(Brightness brightness) {
  final bool isDark = brightness == Brightness.dark;
  final Color onSurface =
      isDark ? AppColors.onSurfaceDark : AppColors.onSurface;
  final Color onSurfaceVariant =
      isDark ? AppColors.onSurfaceVariantDark : AppColors.onSurfaceVariant;

  return TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: AppTypography.displayLarge,
      fontWeight: FontWeight.w700,
      height: AppTypography.tight,
      letterSpacing: AppTypography.letterSpacingTighter,
      color: onSurface,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: AppTypography.displayMedium,
      fontWeight: FontWeight.w700,
      height: AppTypography.tight,
      letterSpacing: AppTypography.letterSpacingTighter,
      color: onSurface,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: AppTypography.displaySmall,
      fontWeight: FontWeight.w700,
      height: AppTypography.snug,
      letterSpacing: AppTypography.letterSpacingTighter,
      color: onSurface,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: AppTypography.headlineLarge,
      fontWeight: FontWeight.w700,
      height: AppTypography.snug,
      letterSpacing: AppTypography.letterSpacingTighter,
      color: onSurface,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: AppTypography.headlineMedium,
      fontWeight: FontWeight.w700,
      height: AppTypography.snug,
      letterSpacing: AppTypography.letterSpacingTighter,
      color: onSurface,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: AppTypography.headlineSmall,
      fontWeight: FontWeight.w700,
      height: AppTypography.normal,
      letterSpacing: AppTypography.normal,
      color: onSurface,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: AppTypography.titleLarge,
      fontWeight: FontWeight.w600,
      height: AppTypography.normal,
      letterSpacing: AppTypography.normal,
      color: onSurface,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: AppTypography.titleMedium,
      fontWeight: FontWeight.w600,
      height: AppTypography.normal,
      letterSpacing: AppTypography.normal,
      color: onSurface,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: AppTypography.titleSmall,
      fontWeight: FontWeight.w600,
      height: AppTypography.normal,
      letterSpacing: AppTypography.letterSpacingWide,
      color: onSurface,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: AppTypography.bodyLarge,
      fontWeight: FontWeight.w400,
      height: AppTypography.relaxed,
      letterSpacing: AppTypography.letterSpacingWide,
      color: onSurfaceVariant,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: AppTypography.bodyMedium,
      fontWeight: FontWeight.w400,
      height: AppTypography.relaxed,
      letterSpacing: AppTypography.letterSpacingWide,
      color: onSurfaceVariant,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: AppTypography.bodySmall,
      fontWeight: FontWeight.w400,
      height: AppTypography.loose,
      letterSpacing: AppTypography.letterSpacingWider,
      color: onSurfaceVariant.withOpacity(0.8),
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: AppTypography.labelLarge,
      fontWeight: FontWeight.w600,
      height: AppTypography.normal,
      letterSpacing: AppTypography.letterSpacingWidest,
      color: onSurface,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: AppTypography.labelMedium,
      fontWeight: FontWeight.w600,
      height: AppTypography.normal,
      letterSpacing: AppTypography.letterSpacingWidest,
      color: onSurface,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: AppTypography.labelSmall,
      fontWeight: FontWeight.w600,
      height: AppTypography.normal,
      letterSpacing: AppTypography.letterSpacingWidest,
      color: onSurface,
    ),
  );
}

// =============================================================================
// CUSTOM DECORATIONS
// =============================================================================
class AppDecorations {
  static BoxDecoration get card => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    color: Colors.white,
    boxShadow: AppShadows.medium,
  );

  static BoxDecoration get cardWithBorder => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    color: Colors.white,
    border: Border.all(color: AppColors.outline.withOpacity(0.1)),
    boxShadow: AppShadows.subtle,
  );

  static BoxDecoration get subtleElevation => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.md),
    color: Colors.white,
    boxShadow: AppShadows.subtle,
  );

  static BoxDecoration get gradientCard => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    gradient: AppGradients.cardLight,
    boxShadow: AppShadows.medium,
  );

  static BoxDecoration get glassCard => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    gradient: AppGradients.glass,
    border: Border.all(color: AppColors.glassWhite, width: 1),
    boxShadow: AppShadows.large,
  );

  static BoxDecoration get primaryButton => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    gradient: AppGradients.primary,
    boxShadow: AppShadows.glowPrimary,
  );

  static BoxDecoration get accentButton => BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.lg),
    gradient: AppGradients.accent,
    boxShadow: AppShadows.glowTertiary,
  );
}
