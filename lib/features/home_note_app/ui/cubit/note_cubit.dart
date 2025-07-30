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

  String? userId;
  String? username;
  String? email;

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
      emit(NoteSuccess(notes));
    } catch (e) {
      emit(NoteError(e.toString()));
      print(e);
    }
  }

  void addNote() async {
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
    } catch (e) {
      emit(NoteError(e.toString()));
      print(e);
    }
  }
}
