import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/Widgets/widgets/list_tile.dart';
import 'package:fbissalama/models/favorite.dart';
import 'package:fbissalama/models/following.dart';
import 'package:fbissalama/utilities/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
class CurrentJourneyPage extends StatefulWidget {
  const CurrentJourneyPage({Key? key}) : super(key: key);

  @override
  State<CurrentJourneyPage> createState() => _CurrentJourneyPageState();
}

class _CurrentJourneyPageState extends State<CurrentJourneyPage> {
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
              query: Consts.journeyRef.child("journeys"),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation animation, int index) {
                try {
                  return Consumer<Following>(
                    builder:
                        (BuildContext context, Following value, Widget? child) {
                      return Dismissible(
                        key: UniqueKey(),
                        secondaryBackground: buildSwipeActionRight(),
                        background: buildSwipeActionLeft(),
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: <Widget>[
                              eachTile(value, Favorite(
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)[Consts.pathDateJourney]),
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)[Consts.pathTimeJourney]),
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)[Consts.pathSourceCity]),
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)[Consts.pathDestinationCity]),
                                  Text(Map<String, dynamic>.from(
                                      snapshot.value as Map)[Consts.pathPriceJourney]),),),
                            ]),
                        onDismissed: (direction) =>
                            dismissItem(context, index, direction),
                      );
                    },
                  );
                } catch (e) {
                  customSnackBar(context, e.toString(), 3, Colors.white24, Colors.brown, 17);
                  return const Text(
                      "We Can't show you information disabled by the Administrator");
                }
              }),
        ]),
      ),
    );

  }

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
          const SizedBox(width: 50,),
          favorite.price
        ],
      ),
      subtitle: favorite.destination,
      trailing: IconButton(
        icon: following.list.contains(favorite)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border_outlined),
        onPressed: () {
          print(following.list.contains(favorite));
          print(favorite);
          if (following.list.contains(favorite)) {
            following.remove(favorite);
          } else {
            print(following.list);
            following.add(favorite);
          }
          print(following.list.contains(favorite));
          print(following.list);
        },
      ),
    );
  }
  Future<void> dismissItem(
    BuildContext context,
    int index,
    DismissDirection direction,
  ) async {
    // setState(() {
    //   listID.removeAt(index);
    // });

    switch (direction) {
      case DismissDirection.endToStart:
        customSnackBar(context, 'Journey has been deleted', 3, Colors.white24, Colors.brown, 17);
        setState(() {
            try {
              // Consts.JOURNEY_REF.child("journeys").child(
              //     listID[index].toString()).remove();
              // listID.removeAt(index);
            }
            catch (e) {
              customSnackBar(context, e.toString(), 3, Colors.white24, Colors.brown, 17);
            }
          });
        break;
      case DismissDirection.startToEnd:
        // EditFire(listID[index].toString(),
        //     databaseReference.child("journeys").child(
        //         listID[index].toString()).child("date").toString(),
        //     databaseReference.child("journeys").child(
        //         listID[index].toString()).child("time").toString(),
        //   databaseReference.child("journeys").child(
        //     listID[index].toString()).child("destination").toString(),
        //     databaseReference.child("journeys").child(
        //         listID[index].toString()).child("source").toString(),
        // );

      // var dateref = Consts.JOURNEY_REF.child("journeys").child(
      //     listID[index].toString()).child("date");
      // var datesnapshot = await dateref.get();
      // var datefav = datesnapshot.value.toString();
      // var timeref = Consts.JOURNEY_REF.child("journeys").child(
      //     listID[index].toString()).child("time");
      // var timesnapshot = await timeref.get();
      // var timefav = timesnapshot.value.toString();
      // var desref = Consts.JOURNEY_REF.child("journeys").child(
      //     listID[index].toString()).child("destination");
      // var dessnapshot = await desref.get();
      // var desfav = dessnapshot.value.toString();
      // var srcref = Consts.JOURNEY_REF.child("journeys").child(
      //     listID[index].toString()).child("source");
      // var srcsnapshot = await srcref.get();
      // var srcfav = srcsnapshot.value.toString();
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => EditData(index: index,currentID: listID[index].toString(),olddate: datefav,
        //     oldtime: timefav,
        //         des: desfav,
        //     src: srcfav,)));
        // Snack_bar.showSnackBar(context, 'Journey has been edited');
      // print(listID[index].toString() + datefav + timefav + desfav + srcfav);
      //   break;
      // default:
      //   break;

      case DismissDirection.vertical:
        // TODO: Handle this case.
        break;
      case DismissDirection.horizontal:
        // TODO: Handle this case.
        break;
      case DismissDirection.up:
        // TODO: Handle this case.
        break;
      case DismissDirection.down:
        // TODO: Handle this case.
        break;
      case DismissDirection.none:
        // TODO: Handle this case.
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
