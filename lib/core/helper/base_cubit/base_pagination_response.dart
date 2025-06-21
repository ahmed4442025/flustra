class BasePaginationResponse {
  late int currentPage;
  late int lastPage;
  late int total;

  BasePaginationResponse({this.currentPage = 0, this.lastPage = 1, this.total = 0});

  int _parseIntOrZero(dynamic obj) => int.tryParse(obj.toString()) ?? 0;

  BasePaginationResponse.fromJson(Map<String, dynamic> json) {
    currentPage = _parseIntOrZero(json['current_page']);
    lastPage = _parseIntOrZero(json['last_page']);
    total = _parseIntOrZero(json['total']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['total'] = total;
    return data;
  }
}

extension BasePaginationResponseEx on BasePaginationResponse {
  bool getIsLastPage() => currentPage >= lastPage;
}
