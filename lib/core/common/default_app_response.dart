class DefaultAppResponse {
  bool? success;
  String? message;

  DefaultAppResponse({this.success, this.message});

  DefaultAppResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("status")) success = json["status"].toString().toLowerCase() == "success";
    if (json.containsKey("success")) success = json["success"];
    message = json['message'];
  }
}
