import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';

import 'package:sopaki_app/src/shared/responsive/screen.dart';




class LoadingDialog extends StatefulWidget {

  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {

  late Timer timer;

  int selectedIndex = 0;

  final characters = [
      "assets/logos/cud_logo.png",
      "assets/logos/2rc_logo.png",
      "assets/logos/logo_kes_ec.png",
  ];

  @override
  void initState() {

    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        setState(() {
          if (selectedIndex == characters.length -1){
            selectedIndex = 0;
          }else{
            selectedIndex = selectedIndex + 1;
          }
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        width: largeur(context, 200),
        height: hauteur(context, 200),
        padding: EdgeInsets.all(hauteur(context, 16)),
        decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(hauteur(context, 5)))
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                switchInCurve: Curves.ease,
                  duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 0),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                      turns: animation,
                      child: child,
                  );
                },
                child: Image(
                  key: UniqueKey(),
                  image: AssetImage(characters[selectedIndex]),
                  width: hauteur(context, 100),
                  height: hauteur(context, 100),
                ),
              ),
              SizedBox(height: hauteur(context, 16),),
              Text(
                  "Veuillez patienter...",
                style: TextStyle(
                  fontSize: hauteur(context, 18),
                  color: context.colorScheme.primary
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
