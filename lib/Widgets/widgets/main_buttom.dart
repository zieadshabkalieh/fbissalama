import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainButton extends StatelessWidget {
  final Text text;
  final String assetName;
  final VoidCallback onTap;
  final List<Color> colors;

  const MainButton(
      this.colors,this.assetName,{
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Container(
          width: 150,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: colors),
          ),
          child: Center(
            child: assetName != "" ? Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  assetName,
                  height: 25,
                  width: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                text
              ],
            ) : text
          ),
        ),
      ),
    );
    // return SizedBox(
    //   width: 50,
    //   height: 50,
    //   child: ElevatedButton(
    //     onPressed: onTap,
    //     style: ElevatedButton.styleFrom(
    //       primary: Theme.of(context).primaryColor,
    //       shape: hasCircularBorder
    //           ? RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(24.0),
    //             )
    //           : null,
    //     ),
    //     child: text
    //   ),
    // );
  }
}