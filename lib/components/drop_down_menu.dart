import 'package:flutter/material.dart';

import '../assets.dart';
import '../theme.dart';

class DropDownMenu<T> extends StatelessWidget {
  DropDownMenu({
    Key? key,
    required this.value,
    required this.values,
    this.fontSize = 17,
    this.isLoading = false,
    this.onChanged,
    required this.hint,
    this.items,
    required this.children,
    this.validator,
  }) : super(key: key);
  late T value;
  final List<T>? values;
  final double fontSize;
  final bool isLoading;
  final List<String>? items;
  final List<DropdownMenuItem<T>>? children;
  void Function(T?)? onChanged;
  final String hint;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<T>(
          isExpanded: true,
          validator: validator,
          dropdownColor: Colors.black87,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
          icon: AppIcons.chevronDown.svgPicture(),
          // selectedItemBuilder: ,
          borderRadius: BorderRadius.circular(20),
          decoration: InputDecoration(
            constraints: const BoxConstraints(maxHeight: 45),
            suffixIcon: isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator.adaptive(strokeWidth: 1.8),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23)),
            enabledBorder: _border(AppColors.whiteColor),
            // errorBorder: _border(Colors.red),
            // errorText: 'Bos bolp bilmez',
          ),
          selectedItemBuilder: (context) {
            return List.generate(
              items?.length ?? 0,
              (index) => Text(
                items?[index] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          },
          value: value,
          hint: value == null
              ? Text(
                  hint,
                  style: const TextStyle(color: Colors.white),
                )
              : null,
          items: children,
          onChanged: onChanged,
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(23),
      borderSide: BorderSide(
        color: color,
        width: 0.3,
      ),
    );
  }
}
