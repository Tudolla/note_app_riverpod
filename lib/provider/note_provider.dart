import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app_riverpod/model/note_model.dart';
import 'package:note_app_riverpod/services/note_service.dart';

final noteProvider = StateProvider<NoteService>((ref) {
  return NoteService();
});

final fetchNoteProvider = StreamProvider<List<NoteModel>>((ref) async* {
  final getNoteData = FirebaseFirestore.instance
      .collection('noteApp')
      .orderBy('dateTask', descending: false)
      .snapshots()
      .map(
        (event) => event.docs
            .map((snapshot) => NoteModel.fromSnapshot(snapshot))
            .toList(),
      );
  yield* getNoteData;
});

final searchNoteProvider =
    FutureProvider.family<List<NoteModel>, String>((ref, searchTitle) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('noteApp')
      .where('title', isGreaterThanOrEqualTo: searchTitle)
      .where('title', isLessThan: searchTitle + 'z')
      .get();

  return querySnapshot.docs.map((doc) => NoteModel.fromSnapshot(doc)).toList();
});
