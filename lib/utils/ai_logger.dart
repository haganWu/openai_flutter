import 'dart:developer' as dev;

/// Log tools
class AiLogger {
  /// Is Open Logger
  static bool _isEnable = true;

  static set isEnable(bool value) {
    _isEnable = value;
  }

  static void log({required String message, String tag = 'AiLogger'}) {
    if (!_isEnable) return;
    dev.log(message, name: tag);
  }
}
