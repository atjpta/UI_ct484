class GhiChu {
  final String? id;
  final String title;
  final String content;
  final String userId;

  GhiChu(
      {this.id,
      required this.title,
      required this.content,
      required this.userId});

  GhiChu copyWith({
    final String? id,
    final String? title,
    final String? content,
    final String? userId,
  }) {
    return GhiChu(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'id_user': userId,
    };
  }

  static GhiChu fromJson(Map<String, dynamic> json) {
    return GhiChu(
      id: json['id'],
      userId: json['id_user'],
      title: json['title'],
      content: json['content'],
    );
  }
}
