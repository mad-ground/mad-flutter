import 'package:flutter/material.dart';

class CustomButtonGrey extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonGrey({
    required this.text,
    required this.onPressed,
  });

  @override
  State<CustomButtonGrey> createState() => _CustomButtonGreyState();
}

class _CustomButtonGreyState extends State<CustomButtonGrey> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0.05),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
        child: TextButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(270, 50),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Colors.white, // 선의 색상
              width: 2.0, // 선의 두께
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 107, 107, 107),
          elevation: 10,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      ),
    );
  }
}
