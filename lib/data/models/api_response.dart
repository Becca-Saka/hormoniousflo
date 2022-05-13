
class ApiResponse {
  final int? code;
  final dynamic data;
  dynamic others;
  final bool isSuccessful;
  final String? message;

  ApiResponse({
    this.code,
    this.message,
    this.others,
    this.data,
    required this.isSuccessful,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      isSuccessful: json['statusCode'] == 200 ? true : false,
      data: json['payload'] != false ? json['payload'] : null,
    );
  }
  factory ApiResponse.timout() {
    return ApiResponse(
      data: null,
      isSuccessful: false,
      message: 'Request timed out, please try again',
    );
  }
}
