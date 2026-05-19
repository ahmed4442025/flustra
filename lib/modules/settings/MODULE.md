# Settings Module

## 1. Overview

The Settings module allows users to configure application-wide preferences. This includes selecting
the application language to localize the interface, toggling visual themes between light and dark
modes, managing notification configurations, viewing billing subscriptions, and managing their
account session status (log in, log out, or account deletion).

## 2. Core Features

- **Profile Card**: Displays the user's name, email, account role (Admin), and online connectivity
  status. For unauthenticated sessions, it displays a guest avatar and fallback description.
- **Language Selection**: Users can choose their preferred language (English, Arabic, or German)
  from a selection screen or via a quick segmented switch widget.
- **Theme Selection**: Users can toggle between Light and Dark mode instantly.
- **Notification Management**: Quick access to configure push and in-app alert preferences.
- **Billing & Subscriptions**: View payment status, plan details, and billing intervals.
- **Session Control**: Seamless log-out and permanent account deletion actions, complete with styled
  confirmation popups to prevent accidental data loss.
- **Developer Options (Proxy & Theme Showcase)**: Accessible developer tools allowing immediate
  proxy setup/configuration and custom visual theme showcase previews.

## 3. Business Logic & Rules

- **Instant Language Update**: When a user selects a language, the application locale changes
  immediately, updating the UI layout direction (LTR/RTL) and text strings.
- **Instant Theme Selection**: Theme changes trigger immediately using the settings controller,
  applying the new color scheme (Light/Dark) across all active views without requiring a restart.
- **RTL layout compatibility**: Layout spacing and alignments use direction-aware parameters to
  dynamically switch positions according to the language direction (Arabic RTL vs. English/German
  LTR).
- **Accidental Deletion Protection**: Before performing log out or deleting an account, the user
  must explicitly confirm the action via a custom-styled popup dialog.

## 4. Recent Changes

- **Initial Setup**: Created the settings module with the `LanguageSelectionScreen` and
  `LanguageSelectionViewModel` following the MVVM architecture.
- **German Integration**: Fully integrated German (`de`) with full translation sheets, system
  assets, and language options.
- **Settings Screen & View Model**: Ported and implemented the `SettingsScreen` and
  `SettingsViewModel` with customized cards, custom icons, quick theme switches, quick language
  switches, and delete account functionality.
- **Common Dialog Integration**: Implemented a unified, beautiful confirmation dialog structure
  under `lib/core/helper/dialogs/common_dialog.dart` supporting error fallbacks.
- **Developer Options Integration**: Added a dedicated section under the Settings screen to manage
  connection proxy configurations and preview design system elements/colors in the theme showcase.
