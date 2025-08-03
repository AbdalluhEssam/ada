import 'package:ada/core/constants/endpoint_constants.dart';
import 'package:ada/core/network/dio_client.dart';
import '../model/note_req_add_model.dart';
import '../model/notes_model.dart';
import 'note_repo.dart';

class NoteRepoImpl implements NoteRepo {
  final dio = DioClient();

  @override
  Future<NotesModel> getNoteById(String noteId) async {
    final response = await dio.get(
      EndpointConstants.getOnlyNote,
      queryParameters: {'noteId': noteId},
    );
    if (response is Map<String, dynamic>) {
      return NotesModel.fromJson(response as Map<String, dynamic>);
    }
    throw response;
  }

  @override
  Future<String> addNote(NoteRustAddModel note) async {
    final response = await dio.post(
      EndpointConstants.addNote,
      queryParameters: note.toJson(),
    );
    if (response.data['status'] == 'success') {
      return response.data['message'] ?? 'Note added successfully';
    }
    print(response);
    throw Exception(response.data['message'] ?? 'Failed to add note');
  }

  @override
  Future<List<NotesModel>> getAllNotes(String userId) async {
    final response = await dio.get(
      EndpointConstants.getAllNotes,
      queryParameters: {'users_id': userId},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load notes');
    }
    print(response.data); // لمراجعة الشكل
    print(response.data['data'].runtimeType); // هل فعلاً List؟
    print(response.data['data'][0].runtimeType); // هل فعلاً Map؟

    if (response.data['status'] == 'success' && response.data['data'] is List) {
      return (response.data['data'] as List)
          .map((e) => NotesModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<String> deleteNote(String noteId) async {
    final response = await dio.post(
      EndpointConstants.deleteNote, data: {'note_id': noteId},
    );

    if (response.data['status'] == 'success') {
      return response.data['message'] ?? 'Note deleted successfully';
    } else {
      throw Exception(response.data['message'] ?? 'Failed to delete note');
    }
  }

  @override
  Future<String> editeNote(String noteId, String title, String content) async{
    final response =await dio.post(
      EndpointConstants.editNote,
      data: {
        'note_id': noteId,
        'title': title,
        'content': content,
      },
    );
    if (response.data['status'] == 'success') {
      return response.data['message'] ?? 'Note deleted successfully';
    } else {
      throw response;
    }
  }
}
