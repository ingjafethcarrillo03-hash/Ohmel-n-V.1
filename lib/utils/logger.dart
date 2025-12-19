import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogMessage {
  final String message;
  final DateTime timestamp;
  final LogLevel level;

  LogMessage(this.message, this.level) : timestamp = DateTime.now();

  Color get color {
    switch (level) {
      case LogLevel.info:
        return Colors.white;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.success:
        return Colors.green;
    }
  }

  String get prefix {
    switch (level) {
      case LogLevel.info:
        return '🔵 INFO';
      case LogLevel.warning:
        return '🟠 WARN';
      case LogLevel.error:
        return '🔴 ERROR';
      case LogLevel.success:
        return '🟢 SUCCESS';
    }
  }

  @override
  String toString() {
    return '${timestamp.toIso8601String().substring(11, 23)} $prefix: $message';
  }
}

enum LogLevel { info, warning, error, success }

class AppLogger extends ChangeNotifier {
  final List<LogMessage> _logs = [];
  List<LogMessage> get logs => List.unmodifiable(_logs);

  void log(String message, {LogLevel level = LogLevel.info}) {
    if (_logs.length >= 100) {
      _logs.removeAt(0); // Keep only the last 100 logs
    }
    _logs.add(LogMessage(message, level));
    if (kDebugMode) {
      print(message); // Also print to console in debug mode
    }
    notifyListeners();
  }

  void logInfo(String message) => log(message, level: LogLevel.info);
  void logWarning(String message) => log(message, level: LogLevel.warning);
  void logError(String message) => log(message, level: LogLevel.error);
  void logSuccess(String message) => log(message, level: LogLevel.success);

  void clearLogs() {
    _logs.clear();
    notifyListeners();
  }
}



