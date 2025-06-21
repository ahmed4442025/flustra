import 'package:easy_localization/easy_localization.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CustomSmartRefresher extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;
  final Future Function() onLoadMore;
  final bool Function() isLastPage;
  final bool enablePullDown;
  final bool enablePullUp;
  final bool? reverse;
  final ScrollController? scrollController;

  const CustomSmartRefresher({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.onLoadMore,
    required this.isLastPage,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.reverse,
    this.scrollController,
  });

  @override
  State<CustomSmartRefresher> createState() => _CustomSmartRefresherState();
}

class _CustomSmartRefresherState extends State<CustomSmartRefresher> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      scrollController: widget.scrollController,
      controller: _refreshController,
      reverse: widget.reverse,
      onRefresh: () async {
        await widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        await widget.onLoadMore();
        _refreshController.loadComplete();
      },
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      // footer: UTI.footerForLoading(),
      footer: customFooter2(),
      child: widget.child,
    );
  }

  Widget customFooter2() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget? body;
        if (mode == LoadStatus.loading) {
          body = const CircularProgressIndicator();
        } else if (widget.isLastPage()) {
          body = Text(AppStrings.noMoreData.tr());
        }

        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
