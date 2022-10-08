import 'package:fbissalama/models/following.dart';
import 'package:flutter/material.dart';
ListTile eachTile(Following following, Text date,Text time,
    Text source, Text destinatiom, Text price, Text isFav) {
  // listID.add((leadingtext1.data.toString() + leadingtext2.data.toString()).replaceAll(RegExp('[^0-9]'), ''));
  // print("eachtile = theID = $listID");
  return ListTile(
    leading: Column(
      children: [
        date,
        const SizedBox(
          height: 10,
        ),
        time,
      ],
    ),
    title: Row(
      children: [
        source,
        const SizedBox(width: 50,),
        price
      ],
    ),
    subtitle: destinatiom,
    trailing:
    IconButton(
      icon: (isFav != "false")
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border_outlined),
      onPressed: () {
        if (isFav != "false"){
        // following.followingListdate.contains(leadingtext1.data) && following.followingListtime.contains(leadingtext2.data) &&
        // following.followingListdestination.contains(source.data) &&
        //     following.followingListsource.contains(destinatiom.data)) {
          following.remove(
            // leadingtext1.data, leadingtext2.data,
              source.data,
              destinatiom.data);
        } else {
          following.add(
            // leadingtext1.data, leadingtext2.data,
              source.data,
              destinatiom.data);
        }
      },
    ),
  );
}