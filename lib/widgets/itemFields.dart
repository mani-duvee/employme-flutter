import 'package:flutter/material.dart';

class ItemFiels extends StatelessWidget {
  // Required
  final String labelText;

  // Optional
  final IconData? icon;
  final String? valueText;

  // Colors
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;

  // General size
  final double textSize;
  final double iconSize;

  // Label customization
  final Color? labelTextColor;
  final double? labelTextSize;

  // Value customization
  final Color? valueTextColor;
  final double? valueTextSize;

  // Spacing
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  // Width
  final double? maxWidth;

  const ItemFiels({
    super.key,

    // Required
    required this.labelText,

    // Optional
    this.icon,
    this.valueText,

    // Colors
    this.textColor = Colors.black,
    this.iconColor = Colors.grey,
    this.backgroundColor = Colors.transparent,

    // General size
    this.textSize = 14,
    this.iconSize = 20,

    // Label
    this.labelTextColor,
    this.labelTextSize,

    // Value
    this.valueTextColor,
    this.valueTextSize,

    // Spacing
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,

    // Width
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      margin: margin,
      padding: padding,
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon - only show if provided
          if (icon != null) ...[
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            const SizedBox(width: 12),
          ],

          // Label + Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Label - ALWAYS shown
                Text(
                  labelText,
                  style: TextStyle(
                    color: labelTextColor ?? textColor,
                    fontSize: labelTextSize ?? textSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Value - only show if provided
                if (valueText != null && valueText!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    valueText!,
                    style: TextStyle(
                      color: valueTextColor ?? textColor,
                      fontSize: valueTextSize ?? textSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}