import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.hint, required this.keyboardType,  this.suffixIcon,this.obscureText, this.onSaved, this.validator,this.inputFormatters, this.onChanged});
  final String hint;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
inputFormatters: inputFormatters,
      style: AppTextStyles.bold16.copyWith(color: Colors.white),
      onSaved: onSaved ,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      validator: validator==null?(value)
      {
        if(value!.isEmpty)
        {
          return 'هذا الحقل مطلوب';
        }
        return null;
      }:validator,

      decoration:  InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.black
        ),
        filled: true,
        fillColor: const Color(0xFFcc4a4b),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        disabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        hintText: hint,
        hintStyle: AppTextStyles.bold19.copyWith(color:  Colors.grey),
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: suffixIcon,
        ),




      ),
      onChanged:onChanged ,
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(

        borderRadius: BorderRadius.circular(60),
      borderSide: const BorderSide(
        color: Colors.transparent
      )

      );
  }

}
