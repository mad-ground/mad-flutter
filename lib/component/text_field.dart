import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final ValueSetter<String> onChanged;
  final String? initText;

  CustomTextField({
    required this.text,
    required this.onChanged,
    this.initText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: TextFormField(
        initialValue: widget.initText,
        onChanged: (value){
          widget.onChanged(value);
        },
        // controller: _model.emailAddressLoginController,
        obscureText: false,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          hintText: widget.text,
          hintStyle: TextStyle(
                color: Color.fromARGB(255, 147, 147, 147),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
        ),
        maxLines: null,
        // validator:
        //     _model.emailAddressLoginControllerValidator.asValidator(context),
      ),
    );
  }
}
