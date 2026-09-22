import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../common/error_handler/failure.dart';
import 'base_pagination_response.dart';

enum StateType { loading, done, error, loadMore }

enum PaginationMethod { refresh, loadMore }

typedef BaseEitherResponse<T> = Future<Either<Failure, T>>;

class BaseCubit<StatesEnum> extends Cubit<BaseState<StatesEnum>> {
  BaseCubit(StatesEnum currentState) : super(BaseState(currentState)) {
    init();
  }

  // -------------------------- init --------------------------
  void init() {}

  // -------------------------- states --------------------------
  final Map<StatesEnum, StateType> _stateMap = {}; // map contain all the states of cubit

  StateType stateOf(StatesEnum state) => _stateMap[state] ?? StateType.done; // get the state of one api

  void disposeState(dynamic state) {
    _stateMap.remove(state);
    _paginationMap.remove(state);
  }

  // -------------------------- voids --------------------------

  void fire(StatesEnum type, [StateType? stateType]) {
    if (stateType != null) _stateMap[type] = stateType;
    emit((BaseState(type)));
  }

  // ========================== 🔥 fastFire 🔥 ========================== //

  Future<Either<Failure, T>> fastFire<T>({
    required StatesEnum type,
    required Future<Either<Failure, T>> Function() fun,
    Function(Failure l)? onFailure,
    required Function(T r) onSuccess,
    bool callLoading = true,
  }) async {
    if (callLoading) fire(type, StateType.loading); // update state to loading
    var res = await fun(); // call function and wait until finished
    return res.fold(
      (l) {
        l.printInfo("fastFire<$T>"); // print error for debugging
        if (onFailure != null) onFailure(l); // call onFailure if existing
        fire(type, StateType.error); // update state to error
        return left(l); // return left with failure
      },
      (r) {
        onSuccess(r); // call onSuccess
        fire(type, StateType.done); // update state to done
        return right(r); // return right with data
      },
    );
  }

  // -------------------------- pagination --------------------------
  final Map<dynamic, BasePaginationResponse> _paginationMap = {};

  BasePaginationResponse paginationOf(dynamic state) => _paginationMap[state] ?? BasePaginationResponse();

  Future<Either<Failure, T>> fastPagination<T>({
    dynamic paginationKey,
    required StatesEnum type,
    required Future<Either<Failure, T>> Function(int page) fun,
    required Function(T r) onRefreshSuccess,
    required Function(T r) onLoadMoreSuccess,
    required BasePaginationResponse? Function(T t) toMeta,
    required PaginationMethod paginationMethod,
    Function(Failure r)? onFailure,
  }) async {
    paginationKey ??= type;
    BasePaginationResponse paginationInfo = paginationOf(paginationKey);
    // if load more check if not last page or exit
    if (paginationMethod == PaginationMethod.loadMore && paginationInfo.currentPage >= paginationInfo.lastPage) {
      return left(Failure(-1054, "", TypeMsg.none));
    }

    if (paginationMethod == PaginationMethod.refresh) fire(type, StateType.loading); // if refresh only => update state to loading
    if (paginationMethod == PaginationMethod.loadMore) fire(type, StateType.loadMore); // if loadMore only => update state to loadMore pagination

    int nextPage = paginationMethod == PaginationMethod.refresh ? 1 : paginationInfo.currentPage + 1;
    var res = await fun(nextPage); // call function and wait until finished

    return res.fold(
      (l) {
        l.printInfo("fastPagination<$T>"); // print error for debugging
        if (onFailure != null) onFailure(l); // call onFailure if existing
        if (paginationMethod == PaginationMethod.refresh) fire(type, StateType.error); // update state to error
        if (paginationMethod == PaginationMethod.loadMore) fire(type, StateType.done); // update state to error
        return left(l); // return left with failure
      },
      (r) {
        if (toMeta(r) != null) _paginationMap[paginationKey] = toMeta(r)!;
        if (paginationMethod == PaginationMethod.refresh) onRefreshSuccess(r); // call onSuccess
        if (paginationMethod == PaginationMethod.loadMore) onLoadMoreSuccess(r); // call onSuccess
        fire(type, StateType.done); // update state to done
        return right(r); // return right with data
      },
    );
  }

  void showErrorToast(Failure l) => l.showToast();

  // -------------------------- consumer don't do any thing lol --------------------------
  void noOp(dynamic _) {}
}

class BaseState<StatesEnum> {
  StatesEnum type;

  BaseState(this.type);

  @override
  String toString() => 'BaseState{type: $type}';
}

extension StateTypeEX on StateType {
  bool isLoading() => this == StateType.loading;

  bool isDone() => this == StateType.done;

  bool isError() => this == StateType.error;

  bool isPaginationLoadMore() => this == StateType.loadMore;
}
