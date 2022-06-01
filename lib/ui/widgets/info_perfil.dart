

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPerfil extends StatelessWidget {
  const InfoPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTime.now().hour < 12 ? "Buenos días" : DateTime.now().hour < 18 ? "Buenas tardes" : "Buenas noches",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                "Fernando Mogollón Vite",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            "assets/images/fmogollon.jpg",
            height: 64,
            width: 64,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
