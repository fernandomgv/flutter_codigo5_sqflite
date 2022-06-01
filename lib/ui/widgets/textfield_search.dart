
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Buscar",
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.0,
          color: kPrimaryColor.withOpacity(0.45),
        ),
        suffixIcon: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: kSecondaryColor.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
    );
  }
}
