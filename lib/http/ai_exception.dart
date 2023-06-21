/// 异常处理
class AiException implements Exception {
  final String message;

  AiException(this.message);

  @override
  String toString() {
    return message;
  }
}

class AiRequestException implements Exception {
  final String message;
  final int statusCode;

  AiRequestException(this.message, this.statusCode);

  @override
  String toString() {
    return 'RequestFailedException-{message: $message, statusCode:$statusCode}';
  }
}
