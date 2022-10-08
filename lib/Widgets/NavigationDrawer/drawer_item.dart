import 'package:flutter/material.dart';
class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key, required this.name, required this.icon, required this.onPressed}) : super(key: key);
  final String name;
  final IconData icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(height: 40,
        child: Row(children: [
       const Padding(padding: EdgeInsets.fromLTRB(10,0.2,0,0.4)),
          Icon(icon,size: 25,color: Colors.white,)
          ,const SizedBox(height: 40,),
          Text(name,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
        ],),
      ),
    );
  }
}
