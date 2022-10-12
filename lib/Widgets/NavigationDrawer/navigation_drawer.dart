import 'package:fbissalama/Services/auth.dart';
import 'package:fbissalama/Widgets/NavigationDrawer/drawer_item.dart';
import 'package:fbissalama/Widgets/NavigationDrawer/header.dart';
import 'package:fbissalama/Widgets/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Drawer(
        child: Material(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 50, 20, 0),
            child: Column(
              children: [
                headerWidget(),
                const Divider(thickness: 1, height: 20, color: Colors.white),
                const SizedBox(
                  height: 15,
                ),
                DrawerItem(
                  name: '  Add Journey',
                  icon: Icons.add_box_outlined,
                  onPressed: () => onItemPressed(context, index: 0),
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: '  Journeys',
                  icon: Icons.airplanemode_active,
                  onPressed: () => onItemPressed(context, index: 1),
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: '  Favorite Journeys',
                  icon: Icons.airplanemode_active,
                  onPressed: () => onItemPressed(context, index: 2),
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: '  Setting',
                  icon: Icons.settings,
                  onPressed: () => onItemPressed(context, index: 3),
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: '  About us',
                  icon: Icons.info,
                  onPressed: () => onItemPressed(context, index: 4),
                ),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  name: '  Log out',
                  icon: Icons.logout,
                  onPressed: () => onItemPressed(context, index: 5),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Spacer(),
                const Divider(
                  color: Colors.white,
                ),
                const Text(
                  '2022-2023  \n Developed By Shoaib And Kalieh',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onItemPressed(context, {required int index}) {
    // Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/addjourney');
        break;
      case 1:
        Navigator.of(context).pushNamed('/currentjourney');
        break;
      case 2:
        Navigator.of(context).pushNamed('/favoritejourney');
        break;
      case 3:
        Navigator.of(context).pushNamed('/settings');
        break;
      case 4:
        Navigator.of(context).pushNamed('/about');
        break;
      case 5:
        try {
          Auth().logout(context);
          Navigator.of(context).pushReplacementNamed('/');
        } catch (e) {
          customSnackBar(
              context, e.toString(), 3, Colors.white24, Colors.brown, 17);
        }
        break;
      default:
        Navigator.pushReplacementNamed(context, '/');
        break;
    }
  }
}
