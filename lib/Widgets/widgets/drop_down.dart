import 'package:fbissalama/Screens/add_journey.dart';
import 'package:fbissalama/models/provider_controller.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final ProviderController dropDownModel;
  final CallbackDropDown callbackDropDown;
  final List<String> items;
  final String hint;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final double fontSize;

  const DropDown(
    this.dropDownModel,
    this.hint,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.fontSize, {
    super.key,
    required this.items,
    required this.callbackDropDown,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: backgroundColor,
        ),
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: TextStyle(color: textColor, fontSize: fontSize),
          ),
          icon: Icon(Icons.arrow_drop_down, color: iconColor),
          elevation: 16,
          style: TextStyle(color: textColor),
          underline: Container(
            height: 2,
            width: 50,
            color: Colors.white,
          ),
          onChanged: (String? newValue) {
            dropDownModel.update(newValue!, callbackDropDown);
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: fontSize),
              ),
            );
          }).toList(),
        ));
  }
}
