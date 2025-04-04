import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/auth/login_or_register.dart';
import 'package:food_delivery_mobile/components/my_drawer_tile.dart';
import 'package:food_delivery_mobile/pages/home_page.dart';
import 'package:food_delivery_mobile/pages/menu_page.dart';
import 'package:food_delivery_mobile/pages/order_history_page.dart';
import 'package:food_delivery_mobile/pages/settings_page.dart';
import 'package:food_delivery_mobile/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginOrRegister()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return isLandScape
        ? Drawer(
          child: Column(
            children: [
              SizedBox(height: 50),
              MyDrawerTile(
                text: "H O M E",
                icon: Icons.home,
                onTap:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    ),
              ),

              MyDrawerTile(
                text: "M E N U",
                icon: Icons.menu_book,
                onTap:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage()),
                    ),
              ),

              MyDrawerTile(
                text: "O R D E R S",
                icon: Icons.history,
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistoryPage(),
                      ),
                    ),
              ),

              MyDrawerTile(
                text: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),

              const Spacer(),

              MyDrawerTile(
                text: "L O G O U T",
                icon: Icons.logout,
                onTap: () => logout(context),
              ),

              const SizedBox(height: 25),
            ],
          ),
        )
        : Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Image.asset(
                  themeProvider.isDarkMode
                      ? 'assets/images/nomnomgo-logo-dark.png'
                      : 'assets/images/nomnomgo-logo.png',
                  width: 250,
                  height: 250,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(25),
                child: Divider(color: Theme.of(context).colorScheme.tertiary),
              ),

              MyDrawerTile(
                text: "H O M E",
                icon: Icons.home,
                onTap:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    ),
              ),

              MyDrawerTile(
                text: "M E N U",
                icon: Icons.menu_book,
                onTap:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage()),
                    ),
              ),

              MyDrawerTile(
                text: "O R D E R S",
                icon: Icons.history,
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistoryPage(),
                      ),
                    ),
              ),

              MyDrawerTile(
                text: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),

              const Spacer(),

              MyDrawerTile(
                text: "L O G O U T",
                icon: Icons.logout,
                onTap: () => logout(context),
              ),

              const SizedBox(height: 25),
            ],
          ),
        );
  }
}
