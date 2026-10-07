class ErrorResponse {
  final String? status;
  final int? statusCode;
  final String? message;
  final bool? success;
  final Map<String, dynamic>? errors;

  ErrorResponse({
    this.status,
    this.statusCode,
    this.message,
    this.success,
    this.errors,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    // Handle 'message', 'error', and 'detail' keys
    String? msg = json["message"] ?? json["error"] ?? json["detail"];

    if (json["errors"] != null) {
      if (json["errors"] is Map) {
        final Map<String, dynamic> errMap =
        Map<String, dynamic>.from(json["errors"] as Map);
        final List<String> allErrors = [];
        errMap.forEach((key, value) {
          if (value is List) {
            allErrors.addAll(value.map((e) => e.toString()));
          } else {
            allErrors.add(value.toString());
          }
        });
        if (allErrors.isNotEmpty) {
          msg = allErrors.join("\n");
        }
      } else if (json["errors"] is String) {
        msg = json["errors"];
      }
    }

    return ErrorResponse(
      status: json["status"],
      statusCode: json["statusCode"],
      message: msg,
      success: json["success"],
      errors: json["errors"] is Map<String, dynamic> ? json["errors"] : null,
    );
  }
}