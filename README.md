# 🧩 flustra_template

A clean and modular **Flutter template** designed for scalable app development.  
Use this as a base to kickstart your next Flutter project with pre-built structure, localization, theming, and utilities.

---

## 🚀 How to Use This Template

1. **Clone the repository**

   ```bash
   git clone https://github.com/ahmed4442025/flustra.git

   ```

2. **Rename project references**

   - Replace all occurrences of `"flustra_template"` with `"your_new_project_name"` — used for imports in code.
   - Replace all occurrences of `"flustra template"` with `"your new project name"` — used for the app display name.

3. **Change package name**

   - Replace all `"com.flustra.dev"` with `"your.new.package.name"`.
   - Or use the safer package:

     ```bash
     flutter pub run change_app_package_name:main your.new.package.name
     ```

---

## 🧱 Project Structure & Naming Convention

All core components start with the prefix **`App`**:

| Type                    | Class                       |
| ----------------------- | --------------------------- |
| Colors                  | `AppColors`                 |
| Strings                 | `AppStrings`                |
| Cache                   | `AppCache`                  |
| Text Styles             | `AppTextStyles`             |
| Validators              | `AppValidators`             |
| Snackbar                | `AppSneakBar`               |
| Localization Controller | `AppLocalizationController` |
| Context Utilities       | `AppContext`                |
| Settings Manager        | `AppSettingsCubit`          |
| Session Manager         | `AppSessionManager`         |
| Toast Handler           | `AppBotToast`               |

> 🧠 You don't need to call `Theme.of(context)` — it’s already handled for you internally.

---

## 💻 Desktop Devices

To control window size, title, and startup behavior on desktop devices, use the **`WindowInitializer`** class.

> ⚠️ Avoid using `flutter_screenutil` for multi-platform layouts (Windows, Web, etc.) — it’s only suitable for **mobile**.

For responsive design, use:

```dart
MediaQuery.of(context).size
LayoutBuilder(...)
```

---

## ⚙️ Public Settings

### App Settings

Manage all public configurations through the **`AppSettingsCubit`** — do not modify directly.

To customize:

- Add new settings in the `AppSettingsModel` class.
- Include fields in:

  - `fromJson`
  - `toJson`
  - `defaults`

- Then handle them inside `AppSettingsCubit`.

### Localization

To add a new language:

- Use the `LocalizationSupportedData` class (add id, name, locale, etc.).
- To change the default language, edit:

  ```dart
  AppConstant.defaultLanguage
  ```

---

## 🧰 Custom Widgets

### 🖼️ Custom Image Picker

- Allows image selection (supports **Web** using bytes).
- UI can be customized while maintaining the same logic.

### ✅ Widget Validation

- Wrap any widget with validation logic.
- Integrates seamlessly with Flutter’s `Form` widget.

---

## 🛠️ Services

- **Image Compress** (for optimizing image uploads and storage)

---

## 🧩 Debug Utilities

Use:

```dart
printColored("Your message here");
  // or
  "Your message here".printWithColor(
    textColor: ConsoleColor.red,
    backgroundColor: ConsoleColor.white,
    styles: [ConsoleTextStyle.bold],
    );


```

---

## 🧿 Changing the App Icon

1. Replace the icon at:

   ```
   assets/logo/logo.png
   ```

2. Uncomment the `flutter_launcher_icons` section in `pubspec.yaml`.

3. Run:

   ```bash
   flutter pub get
   dart run flutter_launcher_icons
   ```

4. Comment `flutter_launcher_icons` again in `pubspec.yaml`.

> ⚠️ Remember to comment it back afterward — it adds dependencies you don’t need at runtime.

---

## 🎨 Theme Manager

- Supports **color system**, **dark mode**, and **adaptive modes**.
- Easily extendable to fit your design system.

---

## 🧭 App Router

Fully configurable router setup (based on `GoRouter` or `AutoRoute`).

---

## 📝 TODO

- [ ] Change app icon
- [ ] Add custom fonts
- [ ] Create login screen
- [ ] Implement validation classes
- [ ] Add controllers

---

## 🧠 Notes

This template follows **clean architecture principles** with an emphasis on:

- **Scalability**
- **Maintainability**
- **Code readability**
- **Ease of localization and theming**
