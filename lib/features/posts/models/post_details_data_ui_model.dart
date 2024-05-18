import 'dart:convert';

class PostDataDetailsUiModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  PostDataDetailsUiModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
  Map<String, dynamic> toMap() {
    return {
      'userId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory PostDataDetailsUiModel.fromMap(Map<String, dynamic> map) {
    return PostDataDetailsUiModel(
      postId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostDataDetailsUiModel.fromJson(String source) => PostDataDetailsUiModel.fromMap(json.decode(source));
}
