---
trigger: manual
description: "قواعد وأنماط التعامل مع الصفحات والقوائم (Pagination & Lists)"
---

# قواعد التعامل مع الصفحات والقوائم (Pagination & Lists)

هذا الملف يوضح النمط المتبع في المشروع للتعامل مع القوائم التي تدعم التحميل التدريجي (Pagination) بناءً على تنفيذ صفحة الإشعارات.

## 1. هيكلة الـ Controller

عند عمل صفحة تدعم الـ Pagination، يجب أن يحتوي الـ Controller على العناصر التالية:

### المتغيرات الأساسية

- **paginationKey**: مفتاح فريد لكل API يدعم الصفحات.
  ```dart
  final String paginationKey = UniqueKey().toString();
  ```
- **CancelToken**: لإلغاء الطلبات عند الـ dispose.
  ```dart
  final CancelToken _cancel = CancelToken();
  ```
- **الموديل (Response)**: متغير private لتخزين البيانات.

### الدوال المطلوبة

- **onRefresh**: لتصفير البيانات وجلب أول صفحة.
- **onLoadMore**: لجلب الصفحة التالية ودمجها مع البيانات الحالية.
- **isLastPage**: للتأكد من حالة نهاية الصفحات من الـ Cubit.

### مثال للمنطق البرمجي (Logic)

```dart
Future<void> _callApi(PaginationMethod method) async {
  final res = await _cubit.{methodName}(
    paginationMethod: method,
    cancelToken: _cancel,
    state: paginationKey
  );

  res.fold(
    (Failure f) {
      if (method == PaginationMethod.refresh) _response = null;
      f.showToast();
    },
    (ResponseModel model) {
      if (method == PaginationMethod.refresh) {
        _response = model;
      } else if (method == PaginationMethod.loadMore) {
        // دمج البيانات الجديدة مع القديمة
        _response?.data?.addAll(model.data ?? []);
      }
    },
  );
}
```

## 2. هيكلة الـ UI (Screen)

### استخدام CustomSmartRefresher

يجب تغليف القائمة بـ `CustomSmartRefresher` وتمرير الدوال من الـ Controller:

```dart
CustomSmartRefresher(
  onRefresh: _controller.onRefresh,
  onLoadMore: _controller.onLoadMore,
  isLastPage: _controller.isLastPage,
  child: BlockBuilderWidget<FeatureCubit, dynamic>(
    types: [_controller.paginationKey],
    body: (_) => _buildList(isLoading: false),
    loading: (_) => _buildList(isLoading: true),
    error: (_) => _buildList(isLoading: false),
  ),
)
```

### إعدادات القائمة (ListView)

**هام جداً**: عند وضع `ListView` داخل `CustomSmartRefresher` أو أي Scrollable آخر، يجب استخدام الإعدادات التالية لضمان عمل الـ Refresher بشكل صحيح:

- `shrinkWrap: true`
- `physics: const NeverScrollableScrollPhysics()`

```dart
ListView.separated(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemBuilder: (context, index) => ...,
  separatorBuilder: (context, index) => ...,
  itemCount: ...,
)
```

## 3. معالجة أنواع العناصر (Pattern Matching)

عند الضغط على عنصر في القائمة قد يكون له أنواع مختلفة، نستخدم الـ `switch` مع الـ typed getters:

```dart
void onTapItem(ItemModel item) {
  final type = item.getItemType();

  switch (type) {
    case TypeA(:final id):
      // Navigate to A
      break;
    case TypeB():
      // Handle B
      break;
  }
}
```

## 4. قواعد التسمية (Naming Conventions)

- حالات الـ Pagination في الـ Cubit تنتهي بكلمة `State` أو تستخدم الـ `paginationKey`.
- دوال الأحداث في الـ Controller تبدأ بـ `on` (مثل `onRefresh`, `onLoadMore`, `onTapItem`).
- دوال الـ Build في الـ Screen تبدأ بـ `_build`.
