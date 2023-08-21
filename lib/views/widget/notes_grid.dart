import 'package:flutter/material.dart';
import 'package:flutter_my_notes/model/note.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_my_notes/views/widget/notes_grid_item.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.notes});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return LiveGrid.options(
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index, animation) {
        return NotesGridItem(note: notes[index]);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: notes.length,
      options: const LiveOptions(),
    );
  }
}
