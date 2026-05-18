import 'package:flutter/material.dart';

part 'dark_colors.dart';
part 'light_colors.dart';

AppColorsBase colorsManagerNormal = _ColorsManagerLight();
AppColorsBase colorsManagerDark = _ColorsManagerDark();

// ╔══════════════════════════════════════════════════════════════════════════════╗
// ║  Semantic Color Contract (Material 3 aligned)                                ║
// ║                                                                              ║
// ║  Naming follows M3 roles so that Light ↔ Dark swap is automatic.             ║
// ║  Every getter has a one-line doc: "When to use this color".                  ║
// ╚══════════════════════════════════════════════════════════════════════════════╝

abstract class AppColorsBase {
  // ========================== Brand / Primary ==========================

  /// [Primary] - Main brand color. Used for high-emphasis UI like primary buttons,
  /// Floating Action Buttons (FABs), and active states in tabs/navigation menus.
  Color get primary;

  /// [PrimaryHover] - Hover/focus state for primary elements.
  Color get primaryHover;

  /// [PrimaryTint] - Subtle tint of primary color for chips, card backgrounds, or active indicator shapes.
  Color get primaryTint;

  /// [PrimaryTint2] - Slightly stronger primary tint for hover/selected states on tinted surfaces.
  Color get primaryTint2;

  /// [Secondary] - Less prominent brand color. Used for sub-features like filter chips,
  /// toggle switches, or incidental UI components that shouldn't dominate the screen.
  Color get secondary;

  /// [SecondaryTint] - Subtle secondary tint for sub-container background fills.
  Color get secondaryTint;

  /// [OnPrimary] - Contrast color for content on [primary]. Used for text and icons inside
  /// main buttons to ensure they are readable against the brand background.
  Color get onPrimary;

  // ========================== Surfaces ==========================

  /// [Surface] - The base background color for entire screens. Used as the foundation
  /// for Scaffolds and large, flat areas.
  Color get surface;

  /// [SurfaceContainer] - Used for elevated container backgrounds like Cards,
  /// Dialog boxes, and Bottom Sheet surfaces to create depth.
  Color get surfaceContainer;

  /// [SurfaceContainerHigh] - High-visibility surface level. Used for persistent
  /// elements like AppBar headers, search bars, or bottom navigation bars.
  Color get surfaceContainerHigh;

  // ========================== Content / On-surface ==========================

  /// [OnSurface] - Default high-emphasis color on surfaces. Used for primary titles,
  /// main labels, and any critical body text that requires maximum legibility.
  Color get onSurface;

  /// [OnSurfaceVariant] - Medium-priority content on surfaces. Ideal for secondary text,
  /// helper labels, unselected navigation icons, and timestamps.
  Color get onSurfaceVariant;

  // ========================== Outline / Borders ==========================

  /// [Outline] - Medium-contrast boundary. Used for input field outlines,
  /// focused text borders, and clearly defined card boundaries.
  Color get outline;

  /// [OutlineVariant] - Low-contrast divider color. Perfect for horizontal separators,
  /// subtle list dividers, and thin lines that separate sections without being distracting.
  Color get outlineVariant;

  // ========================== States ==========================

  /// [DisabledElement] - Restricted state color. Used for buttons that cannot be clicked,
  /// greyed-out text fields, or inactive options in a list.
  Color get disabledElement;

  // ========================== Accent / Green Success ==========================

  /// [Accent] - Accent color. Used for badges, successes, tags, and highlights.
  Color get accent;

  /// [AccentDeep] - Darker accent variant for text and high-contrast indicators.
  Color get accentDeep;

  /// [AccentTint] - Muted tint of accent color for chip backgrounds.
  Color get accentTint;

  // ========================== Status / Semantic ==========================

  /// [Error] - Critical/Destructive status. Used for error messages, failure states,
  /// and high-risk actions like "Delete Forever" buttons.
  Color get error;

  /// [ErrorTint] - Muted error tint for card alerts.
  Color get errorTint;

  /// [Success] - Positive/Completion status. Used for checkmarks, "Process Success"
  /// toast messages, and positive status indicators (e.g., "Order Delivered").
  Color get success;

  /// [Warning] - Caution/Alert status. Used for warning banners, "Attention Required"
  /// notifications, or pending states that need user review.
  Color get warning;

  /// [WarningTint] - Muted warning tint for card warning fills.
  Color get warningTint;

  /// [Info] - Neutral/Supportive information. Used for tooltips, general system
  /// announcements, and neutral status updates (e.g., "Syncing Data").
  Color get info;

  /// [InfoTint] - Muted info tint for supportive message backgrounds.
  Color get infoTint;

  /// [Cold] - Neutral slate color.
  Color get cold;

  /// [ColdTint] - Muted slate tint.
  Color get coldTint;

  /// [Hint] - Used for placeholder text in input fields or subtle guidance text
  /// that should be less prominent than secondary text.
  Color get hint;

  /// [Overlay] - Overlay color for modal backdrops.
  Color get overlay;
}
