import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:fbissalama/Widgets/widgets/list_tile.dart';
import 'package:fbissalama/models/following.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Following following = Provider.of<Following>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
                child: Text(
              "Favorite Journeys",
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: following.list.length,
                itemBuilder: (context, index) {
                  try {
                    return Consumer<Following>(
                      builder: (context, value, child) {
                        return ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: <Widget>[
                              eachTile(value, value.list[index]),
                            ]);
                      },
                    );
                  } catch (e) {
                    customSnackBar(context, e.toString(), 3, Colors.white24,
                        Colors.brown, 17);
                    return const Text(
                        "We Can't show you information disabled by the Administrator");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
