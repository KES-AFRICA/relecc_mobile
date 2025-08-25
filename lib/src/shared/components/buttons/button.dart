import 'package:flutter/material.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';

enum _ButtonType {
  primary,
  secondary,
  ternary,
  outline,
  grey,
  white,
}

class Button extends StatelessWidget {
  const Button.primary({
    super.key,
    required this.title,
    this.style,
    this.icon,
    this.iconSvgOrPng,
    this.padding,
    this.onPressed,
  }) : _buttonType = _ButtonType.primary;

  const Button.ternary({
    super.key,
    required this.title,
    this.style,
    this.icon,
    this.iconSvgOrPng,
    this.padding,
    this.onPressed,
  }) : _buttonType = _ButtonType.ternary;

  const Button.secondary({
    super.key,
    required this.title,
    this.style,
    this.icon,
    this.iconSvgOrPng,
    this.padding,
    this.onPressed,
  }) : _buttonType = _ButtonType.secondary;

  const Button.outline({
    super.key,
    required this.title,
    this.style,
    this.icon,
    this.iconSvgOrPng,
    this.padding,
    this.onPressed,
  }) : _buttonType = _ButtonType.outline;

  const Button.grey({
    super.key,
    required this.title,
    this.style,
    this.icon,
    this.iconSvgOrPng,
    this.padding,
    this.onPressed,
  }) : _buttonType = _ButtonType.grey;

  const Button.white({
    super.key,
    required this.title,
    this.style,
    this.icon,
    this.iconSvgOrPng,
    this.padding,
    this.onPressed,
  }) : _buttonType = _ButtonType.white;

  final String title;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? iconSvgOrPng;
  final EdgeInsetsGeometry? padding;
  final _ButtonType _buttonType;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    late final Color color;
    late final Color iconColor;
    late final TextStyle? style;

    switch (_buttonType) {
      case _ButtonType.primary:
        color = Theme.of(context).primaryColor;
        style = this.style ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold);
        iconColor = Theme.of(context).colorScheme.onPrimary;
        break;
      case _ButtonType.ternary:
        color = Theme.of(context).colorScheme.tertiary;
        style = this.style ??
            Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold);
        iconColor = Theme.of(context).primaryColor;
        break;
      case _ButtonType.outline:
        color = Theme.of(context).primaryColor;
        iconColor = const Color(0XFF351B59).withOpacity(.5); // Ok, it's used only here
        style =
            this.style ?? Theme.of(context).textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.bold);
        break;
      case _ButtonType.grey:
        color = Theme.of(context).colorScheme.secondary;
        iconColor = Theme.of(context).colorScheme.onSecondary;
        style = this.style ?? Theme.of(context).textTheme.titleLarge;
        break;
      case _ButtonType.secondary:
        iconColor = Theme.of(context).primaryColor;
        color = Theme.of(context).colorScheme.primary.withOpacity(.1);
        style = this.style ?? Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor);
        break;
      case _ButtonType.white:
        iconColor = Theme.of(context).primaryColor;
        color = Theme.of(context).colorScheme.onPrimary;
        style = this.style ?? Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor);
        break;
    }

    if (_buttonType == _ButtonType.outline) {
      return SizedBox(
        height: kMinInteractiveDimension,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(const EdgeInsets.all(Dimens.halfSpacing)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(color: color),
                borderRadius: BorderRadius.circular(Dimens.radius),
              ),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: padding == null ? MainAxisSize.max : MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                  if (title.isNotEmpty) const SizedBox(width: Dimens.spacing),
                ],
                if (iconSvgOrPng != null) ...[
                  iconSvgOrPng!,
                  if (title.isNotEmpty) const SizedBox(width: Dimens.spacing),
                ],
                Text(
                  title,
                  style: style,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: kMinInteractiveDimension,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(Dimens.halfSpacing)),
          backgroundColor: WidgetStateProperty.all(color),
          elevation: const WidgetStatePropertyAll(0),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius))),
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: padding == null ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor,
                ),
                if (title.isNotEmpty) const SizedBox(width: Dimens.spacing),
              ],
              if (iconSvgOrPng != null) ...[
                iconSvgOrPng!,
                if (title.isNotEmpty) const SizedBox(width: Dimens.spacing),
              ],
              Text(
                title,
                style: style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
