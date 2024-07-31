import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app_riverpod/model/note_model.dart';

class NoteService {
  final noteCollection = FirebaseFirestore.instance.collection('noteApp');

  // CREATE NOTE
  void addNewNote(NoteModel noteModel) {
    noteCollection.add(noteModel.toMap());
  }

  void upDateTask(String? docID, bool? valueUpdate) {
    noteCollection.doc(docID).update({
      'idDone': valueUpdate,
    });
  }

  void deleteTask(String? docID) {
    noteCollection.doc(docID).delete();
  }
}
