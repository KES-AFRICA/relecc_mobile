import 'package:flutter/material.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import '../responsive/screen.dart';


class AppAppBar extends StatelessWidget {
  final String title;
  final Widget? customAction;

  const AppAppBar({
    super.key,
    required this.title,
    this.customAction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: context.colorScheme.primary,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: hauteur(context, 18)),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: hauteur(context, 22),
      ),
      // actions: [
      //   customAction ??
      //       IconButton(
      //         icon: Icon(
      //           Icons.notifications_outlined,
      //           color: Colors.white,
      //           size: hauteur(context, 24),
      //         ),
      //         onPressed: () {
      //           // TODO: Implémenter la logique de notification
      //         },
      //       ),
      //   SizedBox(width: hauteur(context, 8)),
      // ],
    );
  }
}
