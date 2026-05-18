---
trigger: manual
---

# Create Repo (Data Layer)
**Task:** Generate Data Layer (API, Repo, RepoImp, Cubit) from a Postman collection using the category prefix `CategoryName`. 

## 1. Endpoints (`_CategoryNameApi`)
- Create private class `_CategoryNameApi`.
- Static endpoints: `final String login = "/api/login";`
- Dynamic endpoints: `final String user(String id) => "/api/user/$id";`
- Global instance in `ApiConstants`: `static final _CategoryNameApi categoryName = _CategoryNameApi();`

## 2. Repo Interface (`CategoryNameRepo`)
- Create `abstract class CategoryNameRepo`.
- **Parameters:** 
  - > 3 parameters → Create a `MethodNameRequest` class.
  - Pagination → Always add an `int page` parameter.
  - **Always** add `CancelToken? cancelToken` as an optional parameter to all methods.
- **Return Type:**
  - Default: `Future<Either<Failure, MethodNameResponse>>`
  - POST/DELETE methods: `Future<Either<Failure, DefaultAppResponse>>` (Do not change name).
  - **GET Response Rule:** If the response class for a GET method doesn't exist yet, create a temporary empty class with only a `fromJson` factory method. ❌ Avoid using `dynamic`.

## 3. Repo Implementation (`CategoryNameImp`)
- Implements `CategoryNameRepo`.
- Separator: `// -------------------------- MethodName --------------------------`
- Ensure `cancelToken` is passed to all methods and then to the `handleResponse` helper.
- Execution: Use `handleResponse` helper.
  - `endPoint`: `ApiConstants.categoryName.endpointName`
  - `asObject`: `(e) => MethodNameResponse.fromJson(e)`
  - `method`: `DioMethod.get` / `DioMethod.post`
  - `data`: `Map<String, dynamic>` or `FormData` (if dataMode is formdata).
  - `query`: Query parameters.
  - `cancelToken`: `cancelToken`
- **Imports:** `dartz`, `Failure`, `ApiConstants`.
- **File Generation:** Generate `Request` files and **temporary `Response`** files (if GET and missing).

## 4. Cubit (`CategoryNameCubit`)
- **Enum:** `CategoryNameCubitTypes` containing `none` + all repo method names.
- **Class:** `class CategoryNameCubit extends BaseCubit<dynamic>`
- **Constructor:** `CategoryNameCubit(this._repo) : super(CategoryNameCubitTypes.none);`
- **DI Getter:** `static CategoryNameCubit get i => getIt<CategoryNameCubit>();`
- Separator: `// ========================== 🔥 MethodName 🔥 ==========================`
- **Methods:** Should accept an optional `dynamic state` parameter.
- **Non-Pagination:** Use `fastFire()`
  ✅ `BaseEitherResponse<MethodNameResponse> methodName({dynamic state}) async => await fastFire(type: state ?? CategoryNameCubitTypes.methodName, fun: () => _repo.methodName(), onSuccess: x, onFailure: (f) => f.printInfo("methodName"));`
- **Pagination:** Use `fastPagination()`
  ✅ `Future<void> list({dynamic state, PaginationMethod paginationMethod = PaginationMethod.none}) async => await fastPagination(type: state ?? CategoryNameCubitTypes.list, fun: (page) => _repo.list(page: page), onSuccess: x, toMeta: (r) => r.data?.pagination, paginationMethod: paginationMethod, onFailure: (f) => f.printInfo("list"));`

## 5. Final Instructions
- Register `Repo` and `Cubit` in `getIt`.
