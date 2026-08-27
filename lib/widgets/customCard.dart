import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  // Card properties
  final double elevation;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;

  // Responsive widths
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;

  // Height
  final double? minHeight;
  final double? maxHeight;

  // Spacing
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    super.key,
    required this.child,

    // Card properties
    this.elevation = 2,
    this.borderRadius = 10,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,

    // Responsive widths
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,

    // Height
    this.minHeight,
    this.maxHeight,

    // Spacing
    this.margin,
    this.padding,
  });

  double getResponsiveWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Mobile
    if (screenWidth < 600) {
      return mobileWidth ?? screenWidth;
    }

    // Tablet
    if (screenWidth < 1024) {
      return tabletWidth ?? screenWidth;
    }

    // Desktop
    return desktopWidth ?? screenWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getResponsiveWidth(context),
      constraints: BoxConstraints(
        minHeight: minHeight ?? 0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      margin: margin,
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: DefaultTextStyle(
            style: TextStyle(
              color: textColor,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}