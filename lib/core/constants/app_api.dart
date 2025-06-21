abstract class ApiConstants {
  static const String baseUrl = "https://gtek.pri-po.com";

  // Api Endpoints
  // -------------------------- control sub task --------------------------
  static String stopTimerForSubTask(String subTaskId) => "/api/subtasks/$subTaskId/store_timer";

  static String startTimerForSubTask(int subTaskId) => "/api/subtasks/$subTaskId/start";

  static String completeSubTask(int subTaskId) => "/api/subtasks/complete/$subTaskId";
  static const String storeSubTask = "/api/subtasks/store";

  // -------------------------- projects + tasks --------------------------
  static String tasksInCategory(int categoryID) => "/api/categories/$categoryID/tasks";
  static const String getAllCategories = "/api/categories";
  static const String addTask = "/api/tasks/add";
}
