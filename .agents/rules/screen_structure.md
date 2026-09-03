---
trigger: manual
---

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
