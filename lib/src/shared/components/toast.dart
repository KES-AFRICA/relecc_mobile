import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';

enum ToastGravity { bottom, top }

enum ToastType { warning, danger, succes, info, error }

const _toastRadius = 15.0;
const _toastIconSize = 18.0;
const _toastYOffset = 30.0;
const _toastAnimDuration = Duration(milliseconds: 300);

class Toast {
  static void show({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    ToastGravity gravity = ToastGravity.top,
  }) {
    clear();

    _ToastView.createToastView(
      context: context,
      duration: duration,
      gravity: gravity,
      message: message,
      type: type,
      onDismissed: () => clear(),
    );
  }

  static void clear() {
    _ToastView.cancelTimer();
    _ToastView.dismiss();
  }
}

class _ToastView {
  static final _ToastView _singleton = _ToastView._internal();

  factory _ToastView() {
    return _singleton;
  }

  _ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;

  static bool _isToastVisible = false;

  static Timer? _timer;

  static void createToastView({
    required BuildContext context,
    required Duration duration,
    required ToastGravity gravity,
    required String message,
    required ToastType type,
    VoidCallback? onDismissed,
  }) async {
    overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return _ToastWidget(
          message: message,
          type: type,
          gravity: gravity,
          onDismissed: onDismissed,
        );
      },
    );
    _isToastVisible = true;
    overlayState!.insert(_overlayEntry!);
    _timer = Timer(duration, () {
      dismiss();
    });
  }

  static void cancelTimer() {
    _timer?.cancel();
  }

  static Future<void> dismiss() async {
    if (!_isToastVisible) {
      return;
    }
    cancelTimer();
    _isToastVisible = false;
    _overlayEntry?.remove();
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.type,
    required this.gravity,
    this.onDismissed,
  });

  final ToastType type;
  final String message;
  final ToastGravity gravity;
  final VoidCallback? onDismissed;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  final double _initialOffset = -100;
  late double _offset;

  @override
  void initState() {
    super.initState();
    _offset = _initialOffset;
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        _offset = _toastYOffset;
      });
    });
  }

  Future<void> clearToast() async {
    setState(() {
      _offset = _initialOffset;
    });
    await Future.delayed(_toastAnimDuration);
  }

  @override
  Widget build(BuildContext context) {
    final Color toastColor = () {
      switch (widget.type) {
        case ToastType.warning:
          return const Color(0XFFFEF6EC);
        case ToastType.danger:
          return const Color(0XFFFEF3F0);
        case ToastType.succes:
          return const Color(0XFF26A677);
        case ToastType.info:
          return Colors.blueAccent;
        case ToastType.error:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }();

    final Widget icon = () {
      switch (widget.type) {
        case ToastType.warning:
          return _ToastIconDecorator(
            icon: SvgPicture.asset(Assets.iconsWarning),
            type: widget.type,
          );
        case ToastType.danger:
          return _ToastIconDecorator(
            icon: SvgPicture.asset(
              Assets.iconsCloseCircle,
              height: Dimens.doubleSpacing,
              width: Dimens.doubleSpacing,
            ),
            type: widget.type,
          );
        case ToastType.succes:
          return _ToastIconDecorator(
            icon: const Icon(Icons.check, color: Colors.white),
            type: widget.type,
          );
        case ToastType.info:
          return _ToastIconDecorator(
            icon: const Icon(IconsaxPlusLinear.info_circle, color: Colors.white),
            type: widget.type,
          );
        case ToastType.error:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }();

    Color foreground = () {
      switch (widget.type) {
        case ToastType.warning:
        case ToastType.danger:
          return const Color(0XFF101561);
        case ToastType.succes:
        case ToastType.info:
          return Colors.white;
        case ToastType.error:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }();

    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        if (details.delta.dy < 0) {
          widget.onDismissed?.call();
        }
      },
      child: Stack(
        children: [
          AnimatedPositioned(
            top: widget.gravity == ToastGravity.top
                ? _offset + MediaQuery.of(context).viewInsets.top + Dimens.spacing
                : null,
            bottom: widget.gravity == ToastGravity.bottom ? _offset + (MediaQuery.of(context).viewInsets.bottom) : null,
            duration: _toastAnimDuration,
            child: Container(
              width: MediaQuery.of(context).size.width - (Dimens.doubleSpacing),
              margin: const EdgeInsets.all(Dimens.spacing),
              decoration: BoxDecoration(
                color: toastColor,
                borderRadius: BorderRadius.circular(_toastRadius),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 30,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing),
                child: Row(
                  children: [
                    icon,
                    const SizedBox(width: Dimens.spacing),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: foreground),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToastIconDecorator extends StatelessWidget {
  final ToastType type;
  final Widget icon;

  const _ToastIconDecorator({
    required this.type,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color color = () {
      switch (type) {
        case ToastType.warning:
          return context.theme.colorScheme.onPrimary;
        case ToastType.danger:
          return context.colorScheme.error;
        case ToastType.succes:
          return const Color(0XFF00BFA5);
        case ToastType.info:
          return Colors.blueAccent;
        case ToastType.error:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.halfSpacing),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color.withOpacity(.4),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.halfSpacing),
            child: IconTheme(
              data: IconThemeData(
                size: _toastIconSize,
                color: color,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}

mixin ToastFactory {
  void showSuccessToast({
    required BuildContext context,
    ToastGravity gravity = ToastGravity.top,
    required String message,
  }) {
    Toast.show(
      message: message,
      gravity: gravity,
      type: ToastType.succes,
      context: context,
    );
  }

  void showErrorToast({
    required BuildContext context,
    ToastGravity gravity = ToastGravity.top,
    required String message,
  }) {
    Toast.show(
      message: message,
      gravity: gravity,
      type: ToastType.danger,
      context: context,
    );
  }

  void showWarningToast({
    required BuildContext context,
    ToastGravity gravity = ToastGravity.top,
    required String message,
  }) {
    Toast.show(
      context: context,
      gravity: gravity,
      message: message,
      type: ToastType.warning,
    );
  }

  void showInfoToast({
    required BuildContext context,
    ToastGravity gravity = ToastGravity.top,
    required String message,
  }) {
    Toast.show(
      message: message,
      gravity: gravity,
      type: ToastType.info,
      context: context,
    );
  }
}
