int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  // Speed = Distance/Time
  final readingTime = 255 / wordCount;
  return readingTime.ceil();
}
