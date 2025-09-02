class ApiGeneralModel<T> {
  final bool success;
  final String message;
  final T? data;

  ApiGeneralModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiGeneralModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiGeneralModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
