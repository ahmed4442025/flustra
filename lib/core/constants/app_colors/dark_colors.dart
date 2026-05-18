part of 'app_colors.dart';

// ========================== Dark Theme ==========================

class _ColorsManagerDark implements AppColorsBase {
  // --------------------------[ Brand ]-------------------------- //
  @override
  Color get primary => const Color(0xFF22D3EE);

  @override
  Color get primaryHover => const Color(0xFF67E8F9);

  @override
  Color get primaryTint => const Color(0x2422D3EE);

  @override
  Color get primaryTint2 => const Color(0x3822D3EE);

  @override
  Color get secondary => const Color(0xFFCBD5E1);

  @override
  Color get secondaryTint => const Color(0xFF1E293B);

  @override
  Color get onPrimary => const Color(0xFF062A35);

  // --------------------------[ Surfaces ]-------------------------- //
  @override
  Color get surface => const Color(0xFF0F172A);

  @override
  Color get surfaceContainer => const Color(0xFF1F2937);

  @override
  Color get surfaceContainerHigh => const Color(0xFF273344);

  // --------------------------[ Content ]-------------------------- //
  @override
  Color get onSurface => const Color(0xFFF9FAFB);

  @override
  Color get onSurfaceVariant => const Color(0xFF9CA3AF);

  // --------------------------[ Outline ]-------------------------- //
  @override
  Color get outline => const Color(0xFF475569);

  @override
  Color get outlineVariant => const Color(0xFF334155);

  // --------------------------[ States ]-------------------------- //
  @override
  Color get disabledElement => const Color(0xFF94A3B8);

  // --------------------------[ Accent / Lime success ]-------------------------- //
  @override
  Color get accent => const Color(0xFFA3E635);

  @override
  Color get accentDeep => const Color(0xFF84CC16);

  @override
  Color get accentTint => const Color(0x29A3E635);

  // --------------------------[ Status ]-------------------------- //
  @override
  Color get error => const Color(0xFFF87171);

  @override
  Color get errorTint => const Color(0x29F87171);

  @override
  Color get success => const Color(0xFFA3E635);

  @override
  Color get warning => const Color(0xFFFBBF24);

  @override
  Color get warningTint => const Color(0x29FBBF24);

  @override
  Color get info => const Color(0xFF60A5FA);

  @override
  Color get infoTint => const Color(0x2960A5FA);

  @override
  Color get cold => const Color(0xFF94A3B8);

  @override
  Color get coldTint => const Color(0x2994A3B8);

  @override
  Color get hint => const Color(0xFF6B7280);

  @override
  Color get overlay => const Color(0x99000000);
}
