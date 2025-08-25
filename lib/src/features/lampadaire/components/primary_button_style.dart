import 'package:flutter/material.dart';

ButtonStyle primaryButtonStyle ({Color? bgColor}){
  return ElevatedButton.styleFrom(
    elevation: 5, backgroundColor: bgColor ?? const Color.fromRGBO(0, 78, 112, 1),
    minimumSize: const Size.fromHeight(60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}