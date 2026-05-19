# Home With Navigation Bar Module

## Overview

This module manages the main screen navigation shell of the application, featuring a bottom
navigation bar layout. It acts as the wrapper container for the core dashboard tabs.

## Core Features

- Users can switch between key sections of the application: Home, Leads, Chat, Alerts, and Settings.
- Visual active tab indicators, matching the state and design system styling.
- A notification badge displaying count on the Alerts tab.
- Integrated hardware back-button handling, returning to the Home tab before prompting exit.

## Business Logic & Rules

- Bottom navigation tabs correspond to `MainScreenPageType` enum options.
- The Alerts tab displays a notification badge when there are active/unread items.
- Pressing back on Android from any secondary tab will first navigate back to the Home tab; pressing
  back on the Home tab will show a exit confirmation dialog.

## Recent Changes

- Migrated bottom navigation bar style, tabs, and behavior from the agent project to the template.
- Defined translation strings and mappings for home, leads, chat, and alerts tabs in English,
  Arabic, and German.
- Replaced notched FAB with flat bottom container.
