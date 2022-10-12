import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/Widgets/widgets/list_tile.dart';
import 'package:fbissalama/models/favorite.dart';
import 'package:fbissalama/models/following.dart';
import 'package:fbissalama/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class CurrentJourneyPage extends StatelessWidget {
  const CurrentJourneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
              child: Text(
            "Journeys",
            style: TextStyle(fontSize: 20),
          )),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Color(0xFFEAD9DA),
            height: 3.5,
          ),
          const SizedBox(
            height: 20,
          ),
          FirebaseAnimatedList(
              shrinkWrap: true,
              query: Consts.journeyRef.child(Consts.pathJourneys),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation animation, int index) {
                try {
                  return Consumer<Following>(
                    builder: (context, value, child) {
                      return Dismissible(
                        key: UniqueKey(),
                        secondaryBackground: buildSwipeActionRight(),
                        background: buildSwipeActionLeft(),
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: <Widget>[
                              eachTile(
                                value,
                                Favorite(
                                  Text(Map<String, dynamic>.from(snapshot.value
                                      as Map)[Consts.pathDateJourney]),
                                  Text(Map<String, dynamic>.from(snapshot.value
                                      as Map)[Consts.pathTimeJourney]),
                                  Text(Map<String, dynamic>.from(snapshot.value
                                      as Map)[Consts.pathSourceCity]),
                                  Text(Map<String, dynamic>.from(snapshot.value
                                      as Map)[Consts.pathDestinationCity]),
                                  Text(Map<String, dynamic>.from(snapshot.value
                                      as Map)[Consts.pathPriceJourney]),
                                ),
                              )
                            ]),
                        onDismissed: (direction) => dismissItem(
                            context, index, direction, value, snapshot.key),
                      );
                    },
                  );
                } catch (e) {
                  customSnackBar(context, e.toString(), 3, Colors.white24,
                      Colors.brown, 17);
                  return const Text(
                      "We Can't show you information disabled by the Administrator");
                }
              }),
        ]),
      ),
    );
  }

  Future<void> dismissItem(BuildContext context, int index,
      DismissDirection direction, following, snapShot) async {
    switch (direction) {
      case DismissDirection.endToStart:
        customSnackBar(context, 'Journey has been deleted', 3, Colors.white24,
            Colors.brown, 17);
        try {
          Consts.journeyRef.child(Consts.pathJourneys).child(snapShot).remove();
        } catch (e) {
          customSnackBar(
              context, e.toString(), 3, Colors.white24, Colors.brown, 17);
        }
        break;
      case DismissDirection.startToEnd:
        break;
      default:
        break;
    }
  }

  Widget buildSwipeActionRight() => Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: AlignmentDirectional.centerStart,
        color: Colors.green,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      );
}
