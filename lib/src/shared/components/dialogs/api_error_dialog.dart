import 'package:flutter/material.dart';
import 'package:sopaki_app/src/core/i18n/l10n.dart';

class ApiErrorDialog {
  static void show({
    required BuildContext context,
    required String error,
  }) {
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(I18n.of(context).okay),
            ),
          ],
        );
      },
    );
  }
}
