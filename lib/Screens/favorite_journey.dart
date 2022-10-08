import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/Widgets/widgets/list_tile.dart';
import 'package:fbissalama/models/following.dart';
import 'package:fbissalama/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FirebaseAnimatedList(
    shrinkWrap: true,
    query: Consts.journeyRef.child("journeys"),
    itemBuilder: (BuildContext context, DataSnapshot snapshot,
    Animation animation, int index) {
    try {
    Following following = Provider.of<Following>(context);
    return Consumer<Following>(
    builder:
    (BuildContext context, Following value, Widget? child) {
    return ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: <Widget>[
    eachTile(
    following,
    Text(Map<String, dynamic>.from(
    snapshot.value as Map)[Consts.pathDateJourney]),
    Text(Map<String, dynamic>.from(
    snapshot.value as Map)[Consts.pathTimeJourney]),
    Text(Map<String, dynamic>.from(
    snapshot.value as Map)[Consts.pathSourceCity]),
    Text(Map<String, dynamic>.from(
    snapshot.value as Map)[Consts.pathDestinationCity]),
    Text(Map<String, dynamic>.from(
    snapshot.value as Map)[Consts.pathPriceJourney]),
    Text(Map<String, dynamic>.from(
    snapshot.value as Map)[Consts.pathIsFavorite])),
    ]);
    },
    );
    } catch (e) {
      customSnackBar(context, e.toString(), 3, Colors.white24, Colors.brown, 17);
    return const Text(
    "We Can't show you information disabled by the Administrator");
    }
    }),
    );
  }
}
