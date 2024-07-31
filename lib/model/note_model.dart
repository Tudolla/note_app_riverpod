// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? docID;
  final String title;
  final String description;
  final String category;
  final String dateTask;
  final String timeTask;
  final bool idDone;

  NoteModel({
    this.docID,
    required this.title,
    required this.description,
    required this.category,
    required this.dateTask,
    required this.timeTask,
    required this.idDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'category': category,
      'dateTask': dateTask,
      'timeTask': timeTask,
      'idDone': idDone,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
      idDone: map['idDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
  factory NoteModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return NoteModel(
      docID: doc.id,
      title: doc['title'],
      description: doc['description'],
      category: doc['category'],
      dateTask: doc['dateTask'],
      timeTask: doc['timeTask'],
      idDone: doc['idDone'],
    );
  }

  // factory NoteModel.fromJson(String source) => NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
