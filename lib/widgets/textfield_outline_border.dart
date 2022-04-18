import 'package:al_murafiq/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TextFieldOutlineBorder extends StatelessWidget {
  const TextFieldOutlineBorder({
    Key key,
    @required this.hintText,
    @required this.keyboardType,
    @required this.textInputAction,
    this.error,
    this.onTap,
    this.obscure = false,
    this.obscureChanged,
    this.enabled = true,
    this.focusNode,
    this.nextFocusNode,
    this.onChanged,
    this.controller,
  }) : super(key: key);
  final String hintText;

  final String error;
  final GestureTapCallback onTap;
  final bool enabled;

  final bool obscure;
  final VoidCallback obscureChanged;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFE0E7FF),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(width: 1, color: context.accentColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(width: 1, color: Colors.black54),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(width: 1, color: Color(0xFFC2C3DF)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(width: 1)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(width: 1, color: Colors.red.shade800)),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16, color: Color(0xFF9797AD)),
        errorText: error,
        suffixIcon: obscureChanged != null
            ? IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                  color: obscure ? Colors.grey : const Color(0xFF383B6E),
                ),
                onPressed: obscureChanged,
              )
            : null,
      ),
      onTap: onTap,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscure,
      focusNode: focusNode,
      onChanged: onChanged,
      controller: controller,
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(nextFocusNode);
      },
      // controller: _passwordController,
      // onChanged: _authenticationFormBloc.onPasswordChanged,
    );
  }
}
