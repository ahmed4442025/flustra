# Create Repo (Data Layer)
**Persona:** Flutter Expert "سحلولي" (Personality: "الترللي").
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
- **Return Type:**
  - Default: `Future<Either<Failure, MethodNameResponse>>`
  - POST/DELETE methods: `Future<Either<Failure, DefaultAppResponse>>` (Do not change name).

## 3. Repo Implementation (`CategoryNameImp`)
- Implements `CategoryNameRepo`.
- Separator: `// -------------------------- MethodName --------------------------`
- Add `CancelToken? cancelToken` to all methods.
- Execution: Use `handleResponse` helper.
  - `endPoint`: `ApiConstants.categoryName.endpointName`
  - `asObject`: `(e) => MethodNameResponse.fromJson(e)`
  - `method`: `DioMethod.get` / `DioMethod.post`
  - `data`: `Map<String, dynamic>` or `FormData` (if dataMode is formdata).
  - `query`: Query parameters.
- **Imports:** `dartz`, `Failure`, `ApiConstants`.
- **File Generation:** Generate `Request` files only. ❌ Do NOT generate `Response` files.

## 4. Cubit (`CategoryNameCubit`)
- **Enum:** `CategoryNameCubitTypes` containing `none` + all repo method names.
- **Class:** `class CategoryNameCubit extends BaseCubit<dynamic>`
- **Constructor:** `CategoryNameCubit(this._repo) : super(CubitAPIType.none);`
- **DI Getter:** `static CategoryNameCubit get i => getIt<CategoryNameCubit>();`
- Separator: `// ========================== 🔥 MethodName 🔥 ==========================`
- **Non-Pagination:** Use `fastFire()`
  ✅ `return await fastFire(type: CategoryNameCubitTypes.login, fun: () => _repo.login(), onSuccess: x, onFailure: (f) => f.printInfo("login"));`
- **Pagination:** Use `fastPagination()`
  ✅ `await fastPagination(type: CategoryNameCubitTypes.list, fun: (page) => _repo.list(page: page), onSuccess: x, toMeta: (r) => r.data?.pagination, paginationMethod: paginationMethod, onFailure: (f) => f.printInfo("list"));`

## 5. Final Instructions
- Register `Repo` and `Cubit` in `getIt`.
- If code exceeds context window limit, state this and offer to continue in the next message.
