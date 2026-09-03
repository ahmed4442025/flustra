---
trigger: manual
---

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
