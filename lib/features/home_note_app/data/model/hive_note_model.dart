import 'package:hive/hive.dart';

part 'hive_note_model.g.dart';

@HiveType(typeId: 0)
class HiveNotesModel extends HiveObject {
  @HiveField(0)
  String? noteId;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? content;
  @HiveField(3)
  String? usersId;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;

  HiveNotesModel({
    this.noteId,
    this.title,
    this.content,
    this.usersId,
    this.createdAt,
    this.updatedAt,
  });
}
