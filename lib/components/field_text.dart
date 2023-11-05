import 'package:flutter/material.dart';

import '../theme.dart';

class FieldText extends StatelessWidget {
  final double? maxHeight;
  final int? maxLines;
  final String? prefixIcon;
  final bool password;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onTogglePasscodeVisibilityTap;
  final String? Function(String?)? validator;

  const FieldText({
    super.key,
    this.labelText,
    this.controller,
    this.obscureText = false,
    this.password = false,
    this.onTogglePasscodeVisibilityTap,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.maxHeight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final displayMediumText = AppThemes.darkTheme.textTheme.displayMedium;
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      style: displayMediumText,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        prefixIcon: prefixIcon != null ? Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Text(prefixIcon!, style: displayMediumText,),
        ) : null,
        prefixIconConstraints: const BoxConstraints(minHeight: 0),
        hintText: hintText,
        labelText: labelText,
        suffixIcon: password
            ? IconButton(
                onPressed: onTogglePasscodeVisibilityTap,
                icon: obscureText
                    ? const Icon(
                        Icons.remove_red_eye_outlined,
                        size: 24,
                        color: AppColors.greyColor,
                      )
                    : const Icon(
                        Icons.remove_red_eye_outlined,
                        size: 24,
                        color: AppColors.greyColor,
                      ),
                splashRadius: 22,
                padding: EdgeInsets.zero,
              )
            : null,
        labelStyle: displayMediumText,
        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
          (states) {
            final Color color = states.contains(MaterialState.focused)
                ? AppColors.boldBlueColor
                : AppColors.greyColor;
            return TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            );
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23),
          borderSide: const BorderSide(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
