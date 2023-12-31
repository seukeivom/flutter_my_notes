import 'package:flutter_my_notes/model/note.dart';
import 'package:isar/isar.dart';

class LocalDbServices {
  late Future<Isar> db;

  LocalDbServices() {
    db = openDB();
  }
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([NoteSchema], inspector: true);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveNote({required Note note}) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.notes.putSync(note));
  }

  Stream<List<Note>> listenAllNotes() async* {
    final isar = await db;
    yield* isar.notes.where().watch(fireImmediately: true);
  }

  void deleteNote({required int id}) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.notes.deleteSync(id));
  }
}
