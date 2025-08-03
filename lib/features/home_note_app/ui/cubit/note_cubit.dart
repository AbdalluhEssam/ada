import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/note_req_add_model.dart';
import '../../data/model/notes_model.dart';
import '../../data/repo/note_repo.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepo noteRepo;

  NoteCubit(this.noteRepo) : super(NoteInitial()) {
    getUserData();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<NotesModel> notesList = [];

  String? userId;
  String? username;
  String? email;


  void searchNotes(String query) {
    if (query.isEmpty) {
      emit(NoteSuccess(notesList)); // Show all notes if query is empty
      return;
    }

    final filteredNotes = notesList.where((note) {
      return note.title!.toLowerCase().contains(query.toLowerCase()) ||
             note.content!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(NoteSuccess(filteredNotes));
  }
  void getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId").toString();
    print("userId : $userId");
    email = prefs.getString("email") ?? "";
    username = prefs.getString("username") ?? "";

    getAllNotes();
  }

  void getAllNotes() async {
    if (userId == null) {
      emit(NoteError("User ID is not available"));
      return;
    }
    emit(NoteLoading());

    try {
      final notes = await noteRepo.getAllNotes(userId.toString());
      notesList = notes;
      emit(NoteSuccess(notes));

    } catch (e) {
      emit(NoteError(e.toString()));
      print(e);
    }
  }

  void addNote() async {
    if(formKey.currentState?.validate() == true){

      if (userId == null) {
        emit(NoteError("User ID is not available"));
        return;
      }
      emit(AddNoteLoading());
      try {
        final message = await noteRepo.addNote(
          NoteRustAddModel(
            title: titleController.text,
            content: contentController.text,
            userId: userId.toString(),
          ),
        );

        emit(NoteAddedSuccess(message));
        getAllNotes();
        titleController.clear();
        contentController.clear();
      } catch (e) {
        emit(NoteError(e.toString()));
        print(e);
      }
    }

  }

  void deleteNote(String noteId) async {
    emit(NoteLoading());
    try {
      final message = await noteRepo.deleteNote(noteId);
      emit(NoteDeleteSuccess(message)); // Clear the notes list
      getAllNotes(); // Refresh the notes list
    } catch (e) {
      emit(NoteError(e.toString()));
      print(e);
    }
  }

  void editNote(String noteId) async {
    emit(NoteLoading());
    try {
      final message = await noteRepo.editeNote(noteId, titleController.text, contentController.text);
      emit(NoteEditSuccess(message)); // Clear the notes list
      getAllNotes(); // Refresh the notes list
      titleController.clear();
      contentController.clear();
    } catch (e) {
      emit(NoteError(e.toString()));
      print(e);
    }
  }
}
