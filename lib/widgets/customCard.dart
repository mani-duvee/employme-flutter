import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  // Card properties
  final double elevation;
  final double borderRadius;
  final Color color;

  // Responsive widths
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;

  // Spacing
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    super.key,
    required this.child,

    this.elevation = 2,
    this.borderRadius = 10,
    this.color = Colors.white,

    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,

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
      margin: margin,
      child: Material(
        elevation: elevation,
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}