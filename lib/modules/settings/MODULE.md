# Settings Module

## 1. Overview

The Settings module allows users to configure application-wide preferences. This currently includes
selecting the application language to localize the interface to the user's preferred language.

## 2. Core Features

- **Language Selection**: Users can choose their preferred language (English, Arabic, or German)
  from a list.
- **Language Localization Preview**: The languages in the selection screen are displayed in both
  their localized version and their raw version (native spelling) with their corresponding country
  flag.

## 3. Business Logic & Rules

- **Instant Language Update**: When a user selects a language, the application locale changes
  immediately, updating the UI layout direction (LTR/RTL) and text strings.
- **Visual Feedback**: The selected language displays a distinct border color, primary-colored radio
  button selection, and bold label formatting to clearly indicate it is active.

## 4. Recent Changes

- **Initial Setup**: Created the settings module with the `LanguageSelectionScreen` and
  `LanguageSelectionViewModel` following the MVVM architecture.
- **German Integration**: Fully integrated German (`de`) with full translation sheets, system
  assets, and language options.
