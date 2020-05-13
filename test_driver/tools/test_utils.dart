
Future delayed ({int milliseconds = 666}) async {
  /// 适当延时，让操作节奏慢下来
  return await Future.delayed(Duration(milliseconds: milliseconds));
}

const scrollDuration = Duration(milliseconds: 300);