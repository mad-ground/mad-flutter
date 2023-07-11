import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final ValueSetter<String> onChanged;

  CustomTextField({
    required this.text,
    required this.onChanged,
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
        onChanged: (value){
          widget.onChanged(value);
        },
        // controller: _model.emailAddressLoginController,
        obscureText: false,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          hintText: widget.text,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
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
