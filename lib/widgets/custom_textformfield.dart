import 'package:flutter/material.dart';

class CustomTextFormfield extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? label;
  final String? Function(String?) validator;
  final bool obsecure;

  const CustomTextFormfield({
    super.key,
    required this.controller,
    required this.validator,
    this.label,
    this.obsecure = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<CustomTextFormfield> createState() => _CustomTextFormfieldState();
}

class _CustomTextFormfieldState extends State<CustomTextFormfield> {
  late bool _obsecureText;

  @override
  void initState() {
    super.initState();
    _obsecureText = widget.obsecure;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obsecureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        labelText: widget.label,
        suffixIcon: widget.obsecure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obsecureText = !_obsecureText;
                  });
                },
                icon: Icon(
                    _obsecureText ? Icons.visibility_off : Icons.visibility),
              )
            : null,
      ),
      validator: widget.validator,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}
