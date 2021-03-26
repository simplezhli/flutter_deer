
Future<dynamic> delayed ({int milliseconds = 666}) async {
  /// 适当延时，让操作节奏慢下来
  return Future<dynamic>.delayed(Duration(milliseconds: milliseconds));
}

const Duration scrollDuration = Duration(milliseconds: 300);