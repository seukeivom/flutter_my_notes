// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  final String title;
  final String description;
  final DateTime lastModifier;
  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.lastModifier,
  });

  Note copyWith({
    Id? id,
    String? title,
    String? description,
    DateTime? lastModifier,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      lastModifier: lastModifier ?? this.lastModifier,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'lastModifier': lastModifier.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'] as String,
      description: map['description'] as String,
      lastModifier: DateTime.fromMillisecondsSinceEpoch(map['lastModifier'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, description: $description, lastModifier: $lastModifier)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.lastModifier == lastModifier;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      lastModifier.hashCode;
  }
}
