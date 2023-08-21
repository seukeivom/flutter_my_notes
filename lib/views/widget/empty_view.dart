import 'package:flutter/material.dart';
import 'package:flutter_my_notes/res/assets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(AnimationsAssets.empty),
        Text(
          "Things look empty here. Tap + to start",
          style: GoogleFonts.poppins(fontSize: 18),
        ),
      ],
    );
  }
}
