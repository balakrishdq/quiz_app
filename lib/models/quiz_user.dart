// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String photoUrl;
  final String email;
  final int score;
  User({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.score,
  });

  User copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? email,
    int? score,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'email': email,
      'score': score,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String,
      email: map['email'] as String,
      score: map['score'] as int,
    );
  }

  factory User.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;
    return User.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, photoUrl: $photoUrl, email: $email, score: $score)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        other.email == email &&
        other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        photoUrl.hashCode ^
        email.hashCode ^
        score.hashCode;
  }
}
