import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/shared/widgets/default_text_form_field.dart';

class UpdateProfileFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback onResetPassword;

  const UpdateProfileFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          DefaultTextFormField(
            hintText: 'John Safwat',
            controller: nameController,
            prefixIconImageName: 'user',
          ),
          const SizedBox(height: 16),
          DefaultTextFormField(
            hintText: '01200000000',
            controller: phoneController,
            prefixIconImageName: 'phone',
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onResetPassword,
              child: const Text(
                'Reset Password',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
