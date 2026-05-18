---
trigger: always_on
---

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
