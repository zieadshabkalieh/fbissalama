import 'package:fbissalama/Screens/add_journey.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget{
  final CallbackDropDown callbackDropDown;
  final List<String> items;
  final String hint;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final double fontSize;

  const DropDown(this.hint, this.backgroundColor, this.iconColor, this.textColor, this.fontSize, {super.key, required this.items, required this.callbackDropDown,});

  @override
  State<StatefulWidget> createState() => DropdownState();
}

class DropdownState extends State<DropDown>{
  String hint="";
  @override
  void initState() {
    super.initState();
    hint = widget.hint;
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
         canvasColor: widget.backgroundColor,
    ),
    child: DropdownButton<String>(
      hint: Text(hint, style: TextStyle(color: widget.textColor,fontSize: widget.fontSize),),
      icon: Icon(Icons.arrow_drop_down, color: widget.iconColor),
      elevation: 16,
      style: TextStyle(color: widget.textColor),
      underline: Container(
        height: 2,
        width: 50,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        setState(() {
          hint = newValue!;
          widget.callbackDropDown(newValue);
        });
        },
      items: widget.items
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style: TextStyle(fontSize: widget.fontSize),),
        );
      }).toList(),
    )
    );
  }
}