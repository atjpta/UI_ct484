class NhiemVu {
  final String? id;
  final String title;
  final String content;
  final String userId;
  final String startDate;
  final String startTime;
  final String finishDate;
  final String finishTime;
  final String? completed;

  NhiemVu({
    this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.startDate,
    required this.startTime,
    required this.finishDate,
    required this.finishTime,
    this.completed,
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
    final String? completed,
  }) {
    return NhiemVu(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      finishDate: finishDate ?? this.finishDate,
      finishTime: finishTime ?? this.finishTime,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'id_user': userId,
      'startDate': startDate,
      'startTime': startTime,
      'finishDate': finishDate,
      'finishTime': finishTime,
      'completed': completed,
    };
  }

  static NhiemVu fromJson(Map<String, dynamic> json) {
    return NhiemVu(
      id: json['id'],
      userId: json['id_user'],
      title: json['title'],
      content: json['content'],
      startDate: json['startDate'],
      startTime: json['startTime'],
      finishDate: json['finishDate'],
      finishTime: json['finishTime'],
      completed: json['completed'],
    );
  }
}
