import 'package:dio/dio.dart';
import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';

import '../data/auth_repo.dart';
import '../data/requests/login_request.dart';
import '../data/responses/login_response.dart';

enum AuthCubitTypes { none, login }

class AuthCubit extends BaseCubit<dynamic> {
  final AuthRepo _repo;

  AuthCubit(this._repo) : super(AuthCubitTypes.none);

  static AuthCubit get i => getIt<AuthCubit>();

  // ========================== 🔥 login 🔥 ==========================
  BaseEitherResponse<LoginResponse> login({required LoginRequest loginRequest, CancelToken? cancelToken, dynamic state}) async {
    return await fastFire(
      type: state ?? AuthCubitTypes.login,
      fun: () => _repo.login(loginRequest: loginRequest, cancelToken: cancelToken),
      onSuccess: noOp,
      onFailure: (failure) => failure.printInfo("login"),
    );
  }
}
