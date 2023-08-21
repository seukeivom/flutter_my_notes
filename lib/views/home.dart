import 'package:flutter/material.dart';
import 'package:flutter_my_notes/model/note.dart';
import 'package:flutter_my_notes/res/strings.dart';
import 'package:flutter_my_notes/services/local_db.dart';
import 'package:flutter_my_notes/views/create_note.dart';
import 'package:flutter_my_notes/views/widget/empty_view.dart';
import 'package:flutter_my_notes/views/widget/notes_grid.dart';
import 'package:flutter_my_notes/views/widget/notes_list.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.appName,
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isListView = !isListView;
                      });
                    },
                    icon: Icon(isListView
                        ? Icons.grid_view
                        : Icons.splitscreen_outlined),
                  ),
                ],
              ),
            ),
            // const EmptyView(),
            Expanded(
              child: StreamBuilder<List<Note>>(
                stream: LocalDbServices().listenAllNotes(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const EmptyView();
                  }
                  final notes = snapshot.data!;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isListView
                        ? NotesList(notes: notes)
                        : NotesGrid(notes: notes),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateNoteView()));
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
