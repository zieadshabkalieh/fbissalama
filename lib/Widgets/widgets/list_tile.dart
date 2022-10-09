// import 'package:fbissalama/models/following.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// ListTile eachTile(following, favorite) {
//   return ListTile(
//     leading: Column(
//       children: [
//         favorite.date,
//         const SizedBox(
//           height: 10,
//         ),
//         favorite.time,
//       ],
//     ),
//     title: Row(
//       children: [
//         favorite.source,
//         const SizedBox(width: 50,),
//         favorite.price
//       ],
//     ),
//     subtitle: favorite.destination,
//     trailing: IconButton(
//       icon: following.list.contains(favorite)
//           ? const Icon(Icons.favorite)
//           : const Icon(Icons.favorite_border_outlined),
//       onPressed: () {
//         print(following.list.contains(favorite));
//         print(favorite);
//         if (following.list.contains(favorite)){
//           following.remove(favorite);
//         } else {
//           print(following.list);
//           following.add(favorite);
//         }
//         print(following.list.contains(favorite));
//         print(following.list);
//       },
//     ),
//   );
// }