import 'package:flutter/material.dart';
import 'package:flutter_my_notes/model/note.dart';
import 'package:flutter_my_notes/views/widget/note_list_item.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes});

  final List<Note> notes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteListItem(note: notes[index]);
      },
    );
  }
}
