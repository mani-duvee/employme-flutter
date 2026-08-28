import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  // Label
  final String label;

  // Input
  final TextInputType type;
  final TextEditingController? controller;
  final String? placeholder;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;

  // Size & Spacing
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // Text Style
  final Color textColor;
  final Color backgroundColor;
  final double textSize;
  final FontWeight textWeight;

  // Input Border
  final bool inputSelected;
  final Color inputSelectedColor;

  const InputField({
    super.key,

    // Label
    required this.label,

    // Input
    this.type = TextInputType.text,
    this.controller,
    this.placeholder,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLength,

    // Size & Spacing
    this.height,
    this.padding,
    this.margin,

    // Text Style
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.textSize = 14,
    this.textWeight = FontWeight.normal,

    // Input Border
    this.inputSelected = true,
    this.inputSelectedColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 75.0,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: textWeight,
            ),
          ),

          const SizedBox(height: 6),

          // Input Field
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: type,
              obscureText: obscureText,
              maxLength: maxLength,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: textWeight,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: textColor.withValues(alpha: 0.5),
                  fontSize: textSize,
                  fontWeight: FontWeight.normal,
                ),

                filled: true,
                fillColor: backgroundColor,
                suffixIcon: suffixIcon,

                // Hides the "0/10" style counter Flutter shows by default
                // when maxLength is set. Remove this line if you want it.
                counterText: '',

                contentPadding: padding ??
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),

                // Default Border
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),

                // Normal Border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),

                // Selected / Focused Border
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: inputSelected
                        ? inputSelectedColor
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}