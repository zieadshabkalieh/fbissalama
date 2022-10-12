import 'package:flutter/material.dart';

ListTile eachTile(following, favorite) {
  return ListTile(
    leading: Column(
      children: [
        favorite.date,
        const SizedBox(
          height: 10,
        ),
        favorite.time,
      ],
    ),
    title: Row(
      children: [
        favorite.source,
        const SizedBox(
          width: 50,
        ),
        favorite.price,
      ],
    ),
    subtitle: favorite.destination,
    trailing: IconButton(
      icon: following.list.contains(favorite)
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_border_outlined,
              color: Colors.blueGrey,
            ),
      onPressed: () {
        if (following.list.contains(favorite)) {
          following.remove(favorite);
        } else {
          following.add(favorite);
        }
      },
    ),
  );
}
