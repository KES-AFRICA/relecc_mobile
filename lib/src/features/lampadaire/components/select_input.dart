import 'package:flutter/material.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';

class SelectInput extends StatefulWidget {
  final Common? defaultValue;
  final Common? initialValue;
  final String hint;
  final bool isRequired;
  final List<Common> items;
  final Function(Common?)? onValueChanged;

  const SelectInput({
    super.key,
    this.defaultValue,
    this.initialValue,
    required this.items,
    required this.hint,
    this.isRequired = false,
    this.onValueChanged,
  });

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  Common? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Priorité à initialValue s'il est fourni, sinon defaultValue
    _selectedValue = widget.initialValue ?? widget.defaultValue;
  }

  @override
  void didUpdateWidget(SelectInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Mise à jour si initialValue change
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: hauteur(context, 10)),
        _buildLabel(context),
        _buildDropdown(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: largeur(context, 2),
        bottom: hauteur(context, 2),
      ),
      child: widget.isRequired
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "*",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: hauteur(context, 15),
                  ),
                ),
                SizedBox(width: largeur(context, 2)),
                Text(
                  widget.hint,
                  style: TextStyle(
                    fontSize: hauteur(context, 15),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            )
          : Text(
              widget.hint,
              style: TextStyle(
                fontSize: hauteur(context, 15),
                fontWeight: FontWeight.normal,
              ),
            ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(hauteur(context, 5)),
        border: Border.all(
          color: context.colorScheme.onTertiary,
          width: largeur(context, 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: largeur(context, 12),
          vertical: hauteur(context, 2),
        ),
        child: DropdownButton<Common>(
          value: _selectedValue,
          isExpanded: true,
          underline: const SizedBox(),
          hint: Text(
            'Sélectionnez une option',
            style: TextStyle(
              fontSize: hauteur(context, 15),
            ),
          ),
          items: widget.items.map((Common item) {
            return DropdownMenuItem<Common>(
              value: item,
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: hauteur(context, 15),
                ),
              ),
            );
          }).toList(),
          onChanged: (Common? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onValueChanged?.call(newValue);
          },
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
// import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';
// import 'package:sopaki_app/src/shared/responsive/screen.dart';

// class SelectInput extends StatefulWidget {
//   final Common? defaultValue;
//   final Common? initialValue;
//   final String hint;
//   final bool isRequired;
//   final List<Common> items;
//   final Function(Common?)? onValueChanged;

//   const SelectInput({
//     super.key,
//     this.defaultValue,
//     this.initialValue,
//     required this.items,
//     required this.hint,
//     this.isRequired = false,
//     this.onValueChanged,
//   });

//   @override
//   State<SelectInput> createState() => _SelectInputState();
// }

// class _SelectInputState extends State<SelectInput> {
//   Common? _selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.defaultValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: hauteur(context, 10)),
//         _buildLabel(context),
//         _buildDropdown(context),
//       ],
//     );
//   }

//   Widget _buildLabel(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: largeur(context, 2),
//         bottom: hauteur(context, 2),
//       ),
//       child: widget.isRequired
//           ? Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "*",
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: hauteur(context, 15),
//             ),
//           ),
//           SizedBox(width: largeur(context, 2)),
//           Text(
//             widget.hint,
//             style: TextStyle(
//               fontSize: hauteur(context, 15),
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//         ],
//       )
//           : Text(
//         widget.hint,
//         style: TextStyle(
//           fontSize: hauteur(context, 15),
//           fontWeight: FontWeight.normal,
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(hauteur(context, 5)),
//         border: Border.all(
//           color: context.colorScheme.onTertiary,
//           width: largeur(context, 1),
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: largeur(context, 12),
//           vertical: hauteur(context, 2),
//         ),
//         child: DropdownButton<Common>(
//           value: _selectedValue,
//           isExpanded: true,
//           underline: const SizedBox(),
//           hint: Text(
//             'Sélectionnez une option',
//             style: TextStyle(
//               fontSize: hauteur(context, 15),
//             ),
//           ),
//           items: widget.items.map((Common item) {
//             return DropdownMenuItem<Common>(
//               value: item,
//               child: Text(
//                 item.name,
//                 style: TextStyle(
//                   fontSize: hauteur(context, 15),
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (Common? newValue) {
//             setState(() {
//               _selectedValue = newValue;
//             });
//             widget.onValueChanged?.call(newValue);
//           },
//         ),
//       ),
//     );
//   }
// }