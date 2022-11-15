class NhiemVu {
  final String? id;
  final String title;
  final String content;
  final String userId;
  final String startDate;
  final String startTime;
  final String finishDate;
  final String finishTime;

  NhiemVu({
    this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.startDate,
    required this.startTime,
    required this.finishDate,
    required this.finishTime,
  });

  NhiemVu copyWith({
    final String? id,
    final String? title,
    final String? content,
    final String? userId,
    final String? startDate,
    final String? startTime,
    final String? finishDate,
    final String? finishTime,
  }) {
    return NhiemVu(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        userId: userId ?? this.userId,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        finishDate: finishDate ?? this.finishDate,
        finishTime: finishTime ?? this.finishTime);
  }
}
