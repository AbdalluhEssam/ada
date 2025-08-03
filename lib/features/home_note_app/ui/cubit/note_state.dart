part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class AddNoteLoading extends NoteState {}

final class NoteSuccess extends NoteState {
  final List<HiveNotesModel> notes;

  NoteSuccess(this.notes);
}

final class NoteError extends NoteState {
  final String message;

  NoteError(this.message);
}

final class NoteAddedSuccess extends NoteState {
  final String message;

  NoteAddedSuccess(this.message);
}

final class NoteEditSuccess extends NoteState {
  final String message;

  NoteEditSuccess(this.message);
}

final class NoteDeleteSuccess extends NoteState {
  final String message;

  NoteDeleteSuccess(this.message);
}
