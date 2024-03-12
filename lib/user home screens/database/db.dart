
import 'package:hive/hive.dart';
part 'db.g.dart';

@HiveType(typeId: 3)
class AddNoteUser{
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;


  AddNoteUser({

    this.description,
    this.title,
    this.id
   
  });
}
