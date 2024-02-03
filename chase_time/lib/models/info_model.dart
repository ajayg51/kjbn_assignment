class InfoModel {
  final int failureCount;
  final int successCount;
  final int timeupCount;
  final int attemptCount;
  InfoModel({
    required this.failureCount,
    required this.successCount,
    required this.timeupCount,
    required this.attemptCount,
  });

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      failureCount: map["failureCount"]?.toInt() ?? 0,
      successCount: map["successCount"]?.toInt() ?? 0,
      timeupCount: map["timeupCount"]?.toInt() ?? 0,
      attemptCount: map["attemptCount"]?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'failureCount': failureCount,
      'successCount': successCount,
      'timeupCount': timeupCount,
      'attemptCount': attemptCount,
    };
  }
}
