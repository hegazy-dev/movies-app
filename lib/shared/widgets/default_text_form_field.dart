import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_styles.dart';

class DefaultTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? prefixIconImageName;
  final String? suffixIconImageName;
  final void Function(String)? onChange;
  final bool isPassword;
  final String? Function(String?)? validator;

  const DefaultTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIconImageName,
    this.suffixIconImageName,
    this.onChange,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.textTheme.titleMedium,
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.prefixIconImageName}.svg',
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.white,
                ),
              )
            : widget.suffixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.suffixIconImageName}.svg',
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
              ),
      ),
      controller: widget.controller,
      onChanged: widget.onChange,
      obscureText: isObscure,
      validator: widget.validator,
      autovalidateMode: .onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
