import 'package:flutter/material.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';

class ButtonIcon extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final String? title;
  final double? size;
  final Color? iconColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  const ButtonIcon({
    super.key,
    required this.iconData,
    required this.onTap,
    this.title,
    this.size,
    this.iconColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.fullRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? context.colorScheme.surfaceContainer,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: size,
                color: iconColor ?? context.colorScheme.onSurfaceVariant,
              ),
              if (title != null && title!.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  title!,
                  style: TextStyle(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}