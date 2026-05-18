---
trigger: manual
---

## Pagination API Call

Add `_callApi` to the ViewModel alongside the standard `CancelToken` and state key:

```dart
{ResponseModel}? _response;

List<{Model}> get items => _response?.data ?? [];
bool get isLastPage => _{feature}Cubit.isLastPage(paginationKey);

void init() => onRefresh();

// --------------------------[ onRefresh ]-------------------------- //
Future<void> onRefresh() async => _callApi(PaginationMethod.refresh);

// --------------------------[ onLoadMore ]-------------------------- //
Future<void> onLoadMore() async => _callApi(PaginationMethod.loadMore);

// --------------------------[ _callApi ]-------------------------- //
Future<void> _callApi(PaginationMethod method) async {
  final res = await _{feature}Cubit.{methodName}(
    paginationMethod: method,
    cancelToken: _cancel,
    state: paginationKey,
  );
  res.fold(
    (f) {
      f.showToast();
    },
    (model) {
      if (method == PaginationMethod.refresh) {
        _response = model;
        return;
      }
      _response?.data?.addAll(model.data ?? []);
    },
  );
}
```

## Constraints

- `onLoadMore` → appends new data to existing `_response.data`
- `isLastPage` → delegates to cubit, never track manually

## Screen — `lib/core/helper/widgets/custom_smart_refresher.dart`

Wrap `BlockBuilderWidget` inside `CustomSmartRefresher`:

```dart
CustomSmartRefresher(
  onRefresh: _viewModel.onRefresh,
  onLoadMore: _viewModel.onLoadMore,
  isLastPage: _viewModel.isLastPage,
  child: BlockBuilderWidget<{Feature}Cubit, dynamic>(
    types: [_viewModel.paginationKey],
    body: (_) => _buildList(isLoading: false),
    loading: (_) => _buildList(isLoading: true),
    error: (_) => _buildList(isLoading: false),
  ),
)
```
