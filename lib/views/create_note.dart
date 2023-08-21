import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_my_notes/model/note.dart';
import 'package:flutter_my_notes/res/assets.dart';
import 'package:flutter_my_notes/services/local_db.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';

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
    if (widget.note != null) {
      if (title.isEmpty && description.isEmpty) {
        localDB.deleteNote(id: widget.note!.id);
      } else if (widget.note!.title != title ||
          widget.note!.description != description) {
        final newNote = widget.note!.copyWith(
          title: title,
          description: description,
        );
        localDB.saveNote(note: newNote);
      }
    } else {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                widget.note != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Delete Note?",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Lottie.asset(AnimationsAssets.delete),
                                      Text(
                                        "This note will be permamently deleted!",
                                        style:
                                            GoogleFonts.poppins(fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          localDB.deleteNote(
                                              id: widget.note!.id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Proceed")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"))
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      )
                    : const SizedBox.shrink(),
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
