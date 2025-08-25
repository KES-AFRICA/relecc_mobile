import 'package:flutter/material.dart';
import 'package:sopaki_app/src/shared/components/colors.dart';

import '../../../shared/responsive/screen.dart';

class NumberInput extends StatelessWidget {
  final String hint;
  final bool? focus;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final TextEditingController controller;

  const NumberInput(
      {super.key, required this.hint, this.icon, required this.controller, this.focus, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: hauteur(context, 10),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(hauteur(context, 5)),
            side: BorderSide(color: primaryColor, width: largeur(context, 1)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: TextFormField(
                autofocus: focus ?? false,
                keyboardType: TextInputType.number,
                cursorColor: primaryColor,
                textAlign: TextAlign.start,
                onChanged: onChanged,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        )),
                controller: controller,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
