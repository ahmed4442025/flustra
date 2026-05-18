part of 'app_colors.dart';

// ========================== Light Theme ==========================

class _ColorsManagerLight implements AppColorsBase {
  // --------------------------[ Brand ]-------------------------- //
  @override
  Color get primary => const Color(0xFF0891B2);

  @override
  Color get primaryHover => const Color(0xFF0E7490);

  @override
  Color get primaryTint => const Color(0xFFECFEFF);

  @override
  Color get primaryTint2 => const Color(0xFFCFFAFE);

  @override
  Color get secondary => const Color(0xFF374151);

  @override
  Color get secondaryTint => const Color(0xFFF3F4F6);

  @override
  Color get onPrimary => const Color(0xFFFFFFFF);

  // --------------------------[ Surfaces ]-------------------------- //
  @override
  Color get surface => const Color(0xFFF9FAFB);

  @override
  Color get surfaceContainer => const Color(0xFFFFFFFF);

  @override
  Color get surfaceContainerHigh => const Color(0xFFFFFFFF);

  // --------------------------[ Content ]-------------------------- //
  @override
  Color get onSurface => const Color(0xFF111827);

  @override
  Color get onSurfaceVariant => const Color(0xFF6B7280);

  // --------------------------[ Outline ]-------------------------- //
  @override
  Color get outline => const Color(0xFFD1D5DB);

  @override
  Color get outlineVariant => const Color(0xFFe5e7eb);

  // --------------------------[ States ]-------------------------- //
  @override
  Color get disabledElement => const Color(0xFF94A3B8);

  // --------------------------[ Accent / Lime success ]-------------------------- //
  @override
  Color get accent => const Color(0xFF84CC16);

  @override
  Color get accentDeep => const Color(0xFF65A30D);

  @override
  Color get accentTint => const Color(0xFFECFCCB);

  // --------------------------[ Status ]-------------------------- //
  @override
  Color get error => const Color(0xFFEF4444);

  @override
  Color get errorTint => const Color(0xFFFEE2E2);

  @override
  Color get success => const Color(0xFF84CC16);

  @override
  Color get warning => const Color(0xFFF59E0B);

  @override
  Color get warningTint => const Color(0xFFFEF3C7);

  @override
  Color get info => const Color(0xFF3B82F6);

  @override
  Color get infoTint => const Color(0xFFDBEAFE);

  @override
  Color get cold => const Color(0xFF94A3B8);

  @override
  Color get coldTint => const Color(0xFFE2E8F0);

  @override
  Color get hint => const Color(0xFF9CA3AF);

  @override
  Color get overlay => const Color(0x73111827);
}
