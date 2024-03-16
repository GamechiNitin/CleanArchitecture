import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_x1_news/utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onTap,
      this.color,
      this.margin});
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: 20),
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: color ?? kPrimaryColor,
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              offset: Offset(6, 6),
              spreadRadius: 1,
              blurRadius: 4,
            ),
            BoxShadow(
              color: Colors.indigoAccent.withOpacity(0.1),
              offset: const Offset(-6, -6),
              spreadRadius: 1,
              blurRadius: 4,
            )
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
