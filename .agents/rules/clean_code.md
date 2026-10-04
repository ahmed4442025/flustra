---
trigger: always_on
---

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

- Error handling — log context, rethrow or return fallback
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
