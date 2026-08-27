import 'package:flutter/material.dart';

class Titles extends StatefulWidget {
  final String title;

  // Colors
  final Color textColor;
  final Color backgroundColor;

  // Spacing
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  // Icon
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;

  // Size
  final double? width;
  final double? minHeight;
  final double? maxHeight;

  // Action
  final bool action;
  final IconData actionIcon;
  final Color? actionIconColor;

  // Edit
  final bool edit;
  final VoidCallback? editFunction;

  // View
  final bool view;
  final VoidCallback? viewFunction;

  // Delete
  final bool delete;
  final VoidCallback? deleteFunction;

  const Titles({
    super.key,
    required this.title,

    // Colors
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,

    // Spacing
    this.padding,
    this.margin,

    // Icon
    this.icon,
    this.iconColor,
    this.iconSize = 20,

    // Size
    this.width,
    this.minHeight,
    this.maxHeight,

    // Action
    this.action = false,
    this.actionIcon = Icons.more_vert,
    this.actionIconColor,

    // Edit
    this.edit = false,
    this.editFunction,

    // View
    this.view = false,
    this.viewFunction,

    // Delete
    this.delete = false,
    this.deleteFunction,
  });

  @override
  State<Titles> createState() => _TitlesState();
}

class _TitlesState extends State<Titles> {
  void handleAction(String value) {
    switch (value) {
      case 'edit':
        widget.editFunction?.call();
        break;

      case 'view':
        widget.viewFunction?.call();
        break;

      case 'delete':
        widget.deleteFunction?.call();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: widget.margin,
      padding: widget.padding ?? const EdgeInsets.all(8),

      constraints: BoxConstraints(
        minHeight: widget.minHeight ?? 0,
        maxHeight: widget.maxHeight ?? double.infinity,
      ),

      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),

      child: Row(
        children: [

          // --------------------------------
          // TITLE ICON
          // --------------------------------
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              color: widget.iconColor ?? widget.textColor,
              size: widget.iconSize,
            ),

            const SizedBox(width: 8),
          ],

          // --------------------------------
          // TITLE
          // --------------------------------
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // --------------------------------
          // ACTION MENU
          // --------------------------------
          if (widget.action)
            PopupMenuButton<String>(
              icon: Icon(
                widget.actionIcon,
                color: widget.actionIconColor ?? widget.textColor,
                size: 22,
              ),

              // Space between icon and popup
              offset: const Offset(0, 8),

              // Popup shape
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              // Popup shadow
              elevation: 8,

              // Popup background
              color: Colors.white,

              // Remove the default vertical padding the popup menu
              // adds above/below the whole item list
              padding: EdgeInsets.zero,

              // When item is selected
              onSelected: handleAction,

              // Menu items
              itemBuilder: (context) => [

                // --------------------------------
                // EDIT
                // --------------------------------
                if (widget.edit)
                  PopupMenuItem<String>(
                    value: 'edit',
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: Colors.black87,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                // --------------------------------
                // VIEW
                // --------------------------------
                if (widget.view)
                  PopupMenuItem<String>(
                    value: 'view',
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          size: 18,
                          color: Colors.black87,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'View',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                // --------------------------------
                // DELETE
                // --------------------------------
                if (widget.delete)
                  PopupMenuItem<String>(
                    value: 'delete',
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Colors.red,
                        ),

                        SizedBox(width: 10),

                        Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}