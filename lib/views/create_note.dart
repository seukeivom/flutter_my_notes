import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_my_notes/model/note.dart';
import 'package:flutter_my_notes/services/local_db.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key, this.note});

  final Note? note;
  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleController = TextEditingController();
  final _descriptionsController = TextEditingController();

  final localDB = LocalDbServices();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionsController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();

    log(_titleController.text);
    log(_descriptionsController.text);

    final title = _titleController.text;
    final description = _descriptionsController.text;

    if (title.isNotEmpty || description.isNotEmpty) {
      final newNote = Note(
          id: Isar.autoIncrement,
          title: title,
          description: description,
          lastModifier: DateTime.now());

      localDB.saveNote(note: newNote);
    }

    _titleController.dispose();
    _descriptionsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
                style: GoogleFonts.poppins(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _descriptionsController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Descriptions",
                ),
                style: GoogleFonts.poppins(fontSize: 22),
              ),
            )
          ],
        ),
      ),
    );
  }
}
