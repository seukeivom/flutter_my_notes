import 'package:flutter/material.dart';
import 'package:flutter_my_notes/model/note.dart';
import 'package:flutter_my_notes/views/create_note.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateNoteView(note: note)));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: GoogleFonts.poppins(fontSize: 18),
                      maxLines: 1,
                    ),
                    Text(
                      note.description,
                      style: GoogleFonts.poppins(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
