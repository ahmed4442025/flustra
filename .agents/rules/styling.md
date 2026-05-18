---
trigger: manual
---

# Styling

## RTL

```dart
✅ EdgeInsetsDirectional.only(start: 16, end: 8)  /  AlignmentDirectional.centerStart
❌ EdgeInsets.only(left/right)  /  EdgeInsets.fromLTRB  /  Alignment.centerLeft
❌ if (isArabic) ... // never check language for layout
```

## Colors — `AppColors` from `lib/core/constants/app_defults.dart`

❌ Never `Theme.of(context)` directly.
❌ No hard-coded colors (e.g., `Colors.red`, `Color(0xFF...)`). All colors **must** come from `AppColors`.
✅ `color: AppColors.primary`
✅ `color: AppColors.onSurfaceVariant`

## Text — `AppTextStyle` from same file

```dart
Text('x', style: AppTextStyle.bodyMedium.copyWith(color: AppColors.primary))
```

## Theme & Components — `lib/core/theme/base_theme_data.dart`

❌ No custom `decoration` or `style` for Buttons, TextFields, or AppBars.
✅ Rely on the global theme defined in `base_theme_data.dart` for consistency.
✅ Only override styles if explicitly requested or for extremely unique edge cases.

## Dimensions — `lib/core/helper/utils/dimensions.dart`

## Text Overflow

- Dynamic content (API/user): **must** have `maxLines` + `overflow: TextOverflow.ellipsis`
- Text in `Row`: **must** wrap in `Expanded`/`Flexible`
- Static labels ("Login", "OK"): no constraints needed

# Widgets & Services Rules

> **Note:** Use these widgets and services ONLY when necessary to maintain clean code and optimize performance.

## 🟢 Widget Registry

**Base Path:** `lib/core/helper/widgets/`

- `CustomImageNetwork`: For network images.
- `ImageAssetWidget`: For asset images.
- `CustomSmartRefresher`: For pull-to-refresh logic.
- `CustomValidationWidget`: For displaying validation errors.
- `ShimmerHelper`: For loading skeleton effects.

## 🔵 Service Registry

**Base Path:** `lib/core/services/`

- **Toasts:** `bot_toast/app_bot_toast.dart`
- **Validators:** `app_validators.dart`
- **Price Format:** `price_converter.dart`
- **Date Format:** `date_converter.dart`
- **Session:** `app_session_manager.dart`
