# ViewModel-Cubit Pattern

ViewModel = UI logic separation (NOT state management). Cubit owns state.

## Template

```dart
class {Screen}ViewModel extends ChangeNotifier {
  // ========================== Constructor ========================== //
  {Screen}ViewModel(this._{feature}Cubit);

  // ========================== 🔒 Private variables 🔒 ========================== //
  final {Feature}Cubit _{feature}Cubit;
  final CancelToken _cancel = CancelToken();
  final String {state}State = UniqueKey().toString();
  String? _errorMessage;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  String? get errorMessage => _errorMessage;
  List<{Model}> get {items} => _cubitData?.data ?? [];

  // ========================== 🌍 Public events 🌍 ========================== //
  void init() => _load{Data}();

  // --------------------------[ on{Action} ]-------------------------- //
  void on{Action}() {}

  // ========================== 🔒 Private methods 🔒 ==========================
  // --------------------------[ _load{Data} ]-------------------------- //
  Future<void> _load{Data}() async {
    final res = await _{feature}Cubit.{method}(cancelToken: _cancel, state: {state}State);
    res.fold(
      (f) { _errorMessage = f.message; f.showToast(); },
      (data) { _errorMessage = null; /* update */ },
    );
  }

  @override
  void dispose() {
    _cancel.cancel();
    _{feature}Cubit.disposeState({state}State);
    super.dispose();
  }
}
```

## Constraints

- Cubit field: **private** `final {Feature}Cubit _{feature}Cubit`
- `CancelToken` per ViewModel → cancel in `dispose()` for each API call
- One `UniqueKey().toString()` for each API call
- Data access: **public getters only**, never expose cubit
- `notifyListeners()`: only when rebuild needed without cubit state
- Comment before every method: `// --------------------------[ {name} ]-------------------------- //`
- **No cubit?** → If the screen has no existing cubit, do NOT create one. Use ViewModel alone with `notifyListeners()`.


## Error Handling

API returns `Either<Failure, Response>` → always `res.fold()`:

```dart
✅ res.fold((f) => f.showToast(), (data) => _items = data);
❌ try { await cubit.fetchData(); } catch (e) { ... }
```

## Structure

```
lib/modules/{feature}/
  views/{screen_name}/
    {screen_name}.dart              ← Screen widget
    {screen_name}_view_model.dart   ← ChangeNotifier (UI logic)
  widgets/                          ← Feature-specific reusable widgets
  cubit/                            ← Optional — only if feature needs cubit
  data/                             ← Optional — only if feature has its own repo
```

# Clean Code (IMPORTANT)
You are a senior Flutter expert with expertise in Flutter 3+ and cross-platform mobile development.
Your focus spans architecture patterns, state management, platform-specific implementations,
and performance optimization with emphasis on creating applications that feel truly native on every platform.
you use latest version of flutter and material 3

## Rules

- Guard clauses (fail fast) — no nested if/else
  ✅ `if (items.isEmpty) return; if (!isValid) return; _process();`
  ❌ `if (items.isNotEmpty) { if (isValid) { _process(); } }`

- Arrow `=>` for **single-expression only** — multi-child widgets use `{}`
  ✅ `bool get isEmpty => _items.isEmpty;`
  ✅ `Widget _label() => Text('OK');`
  ❌ `bool get isEmpty { return _items.isEmpty; }`
  ❌ `Widget _body() => Column(children: [_header(), _content()]);`

- No nested ternaries
  ✅ `if (isLoading) return _shimmer(); if (hasError) return _error(); return _content();`
  ❌ `isLoading ? _shimmer() : hasError ? _error() : _content();`

- Complex booleans → descriptive getters
  ✅ `bool get canSubmit => _items.isNotEmpty && _reason.isNotEmpty;`
  ❌ `if (_items.isNotEmpty && _reason.isNotEmpty) { submit() }`

- Skip rebuild if value unchanged + bounds validation
  ✅ `void update(int v) { if (_v == v) return; _v = v.clamp(0, max); notifyListeners(); }`
  ❌ `void update(int v) { _v = v; notifyListeners(); }`

- Error handling — `fold` for `Either`; `try/catch` for thrown exceptions. Log context, then rethrow or return fallback.
  ✅ `try { await _api.send(data); } catch (e) { debugPrint('send failed: $e'); rethrow; }`
  ❌ `try { await _api.send(data); } catch (_) { /* silent swallow */ }`

- Pure methods — depend on input params only
- Separate calculation (getters) from execution (methods)
- Single Responsibility

## Self-Documented Code

- Names **replace** comments — if you need a comment to explain "what", rename instead
  ✅ `final remainingAttempts = maxRetries - currentTry;`
  ❌ `final r = max - c; // remaining attempts`

- Extract complex logic into well-named methods
  ✅ `if (_isEligibleForDiscount(order)) applyDiscount();`
  ❌ `if (order.total > 100 && order.items.length > 3 && !order.hasDiscount) applyDiscount();`

- Comments explain **why**, never **what**
  ✅ `// API returns UTC but UI expects local`
  ❌ `// convert date to local time`

- No magic numbers/strings — use named constants
  ✅ `static const maxUploadSizeMB = 10;`
  ❌ `if (file.size > 10) return;`

- Use enums over string literals for fixed choices
  ✅ `enum Status { pending, approved, rejected }`
  ❌ `if (status == 'pending') ...`

## Naming

- Use descriptive variable, file, and class names that reveal purpose and feature context, even to beginners. Prefer longer names over ambiguity; avoid unclear abbreviations and names easily confused with others in the project.

Bool → `is/has/can` · Events → `on` prefix · Builders → `_build` prefix

## Task Analysis & Evaluation

Before executing any task:
- **Analyze & Rate (0-10)**: Analyze the task and objectively rate the idea/approach from 0 to 10 with complete impartiality.
- **Clarifications & Improvements**: Check if any questions need to be asked, modifications are required, or there is an important improvement to suggest. If so, share them first.
- **Immediate Execution**: If everything is solid and there are no questions or necessary enhancements, proceed with execution immediately.

# Module Documentation (IMPORTANT)

This rule ensures that every module in the project has up-to-date documentation that explains its purpose and features in a clear, high-level manner (PRD style). This allows anyone (technical or non-technical) to understand the module's logic without reading the code.

## Rules

- **Pre-Task Context**: Before starting any task within a module, you MUST read the `MODULE.md` file in that module's directory to understand its business logic and features.
- **Automatic Updates**: When adding a new feature, modifying a workflow, or creating a new module, you MUST update/create the corresponding `MODULE.md`.
- **Non-Technical Focus**: Documentation should explain "What" and "Why" from a product perspective, not "How" from a code perspective. Avoid technical jargon like "Cubit", "Repository", or "Widget".

## Module Document Structure (MODULE.md)

Each `MODULE.md` should follow this structure:

### 1. Overview
A high-level summary of the module's purpose and its role in the overall application.

### 2. Core Features
A list of the main functionalities available to the user in this module.
- ✅ *Example: "User can view a list of assigned route plans for the current day."*
- ❌ *Example: "The HomeCubit fetches data from the RouteRepository."*

### 3. Business Logic & Rules
Any specific rules, constraints, or workflows that the module must follow.
- *Example: "A route plan can only be started if the user is within 100 meters of the market location."*

### 4. Recent Changes
A log of the latest features or modifications added to the module, ensuring the AI and developers stay aligned on the current state.

# Screen, Navigation & Translations

## Screen Template

```dart
class {Screen} extends StatefulWidget {
  const {Screen}({super.key});
  static const String name = AppRoutes.{routeName};
  static void navigateToMe() => navigateTo(name);
  @override
  State<{Screen}> createState() => _{Screen}State();
}

class _{Screen}State extends State<{Screen}> {
  late final {Screen}ViewModel _viewModel = {Screen}ViewModel({Feature}Cubit.i);
  void _refresh() { if (mounted) setState(() {}); }

  @override void initState() { super.initState(); _viewModel.addListener(_refresh); _viewModel.init(); }
  @override void dispose() { _viewModel.removeListener(_refresh); _viewModel.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return Column(children: [
      // --------------------------[ Header ]-------------------------- //
      _buildHeader(),
      const SizedBox(height: 16),
      // --------------------------[ Content ]-------------------------- //
      _buildContent(),
      // --------------------------[ ... ]-------------------------- //
      ...
    ]);
  }
}
```

## Widget Extraction — Avoid Deep Nesting

Every visual section **must** be extracted into a private `_build{Name}()` method.

✅ Correct — flat, readable:

```dart
Widget _buildBody() {
  return Column(children: [
    _buildHeader(),
    const SizedBox(height: 16),
    _buildSearchBar(),
    _buildProductList(),
  ]);
}

Widget _buildHeader() {
  return Row(children: [
    _buildTitle(),
    const Spacer(),
    _buildFilterButton(),
  ]);
}
```

**Rules:**

- Max nesting inside any `_build` method: **3-5 levels** of widgets
- Large or reusable widgets → extract to `lib/modules/{feature}/widgets/`
- `build()` → calls `_buildBody()` only, nothing else

## Layout Constraints

- Wrap all sections in single `Column`
- Vertical spacing: `SizedBox` only — ❌ no `Padding` for vertical separation
- Every section: `// --------------------------[ {Name} ]-------------------------- //` comment before `_build{Name}()`
- Large widget → extract to `lib/modules/{feature}/widgets/`

## Loading States → Always Shimmer

❌ Never use `CircularProgressIndicator` for data loading  
✅ Always use shimmer placeholders that match the widget's layout shape

**Lookup order:**

1. `ShimmerTemplates` → pre-built skeletons (`productCard`, `listTile`, `profileHeader`, `banner`, etc.)  
   Path: `lib/core/helper/uti/shimmer_templates.dart`
2. `ShimmerHelper.buildBasicShimmer()` → custom shape fallback  
   Path: `lib/core/helper/widgets/shimmer_helper.dart`

**Pattern with BlockBuilderWidget2:**

```dart
BlockBuilderWidget2<{Feature}Cubit, dynamic>(
  types: [_viewModel.{state}State],
  body: (_, state) => _buildProducts(isLoading: state == StateType.loading),
);

Widget _buildProducts({required bool isLoading}) {
  if (isLoading) return ShimmerTemplates.productCard();
  return _buildActualContent();
}
```

Path: `lib/core/helper/base_cubit/block_builder_widget.dart`

## Error States & Refresh

- ❌ `state.isError()` alone on refresh (wipes cached data)
- ✅ `if (state.isError() && _viewModel.isEmpty) return CustomErrorWidget(message: _viewModel.errorMessage, onRetry: ...);`
- Refresh failure (`!_viewModel.isEmpty`): keep data on screen + `f.showToast()`
- Widget: `lib/core/helper/widgets/custom_error_widget.dart`

## Event Handlers & Business Logic

❌ Never leave `onTap`, `onPressed`, or similar callbacks empty.
✅ Always create a descriptive method in the **View Model**. include a `print()` for debugging and a `// TODO:` comment.
- For design-only screens, keep these handlers as `print()`/`TODO` placeholders; implement them when behavior or API integration is requested.

## Navigation

1. Define route constant in `AppRoutes`.
2. Register the screen in `lib/core/router/app_router.dart`.
3. ✅ Always use `navigateTo(name)` for navigation without context.
    - Source: `lib/core/router/route_help_methods.dart`

## Translations

**Add key** → `lib/core/localization/app_strings_localizations.dart` (top of file, correct section):
`static const String myKey = 'My key';`

**Constraints:**

- Key value = exact English UI text
- ✅ `AppStrings.x.tx()` · ❌ never `.tr()`
- Extension: `lib/core/extensions/trans_extention.dart`

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
❌ No `Scaffold(backgroundColor: ...)` — defined globally in theme.
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
- `CustomErrorWidget`: For unified full-page error display with retry capability.
- `ShimmerHelper`: For loading skeleton effects.

## 🔵 Service Registry

**Base Path:** `lib/core/services/`

- **Toasts:** `bot_toast/app_bot_toast.dart`
- **Validators:** `app_validators.dart`
- **Price Format:** `price_converter.dart`
- **Date Format:** `date_converter.dart`
- **Session:** `app_session_manager.dart`
