import 'package:flutter/material.dart';

class MenuCategoryName extends StatelessWidget {
  final String categoryName;
  const MenuCategoryName({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          categoryName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            letterSpacing: 2,
          ),
        ),
        Padding(
          padding:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? const EdgeInsets.only(left: 250, right: 250)
                  : EdgeInsets.zero,
          child: Divider(
            color: Theme.of(context).colorScheme.inversePrimary,
            indent: 75,
            endIndent: 75,
          ),
        ),
      ],
    );
  }
}
