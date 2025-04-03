import 'package:flutter/material.dart';
import 'package:food_delivery_mobile/components/my_drawer.dart';
import 'package:food_delivery_mobile/data/key_constants.dart';
import 'package:food_delivery_mobile/pages/cart_page.dart';
import 'package:food_delivery_mobile/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initThemeMode();
  }

  Future<void> initThemeMode() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool repeat = prefs.getBool(KeyConstants.themeModeKey) ?? false;

    if (themeProvider.isDarkMode != repeat) {
      themeProvider.toggleTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Text(
          "HOME",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [Lottie.asset('assets/lotties/cat.json')]),
        ),
      ),
    );
  }
}
