import 'package:ada/features/home_note_app/data/model/notes_model.dart';
import 'package:dio/dio.dart';
import '../model/note_req_add_model.dart';

abstract class NoteRepo {
  Future<List<NotesModel>> getAllNotes(String userId);

  Future<NotesModel> getNoteById(String noteId);

  Future<String> addNote(NoteRustAddModel note);
}
