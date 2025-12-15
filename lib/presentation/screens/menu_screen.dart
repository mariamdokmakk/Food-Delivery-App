import 'package:flutter/material.dart';

import '../widgets/menu_section.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(child: MenuSection()),
      ),
    );
  }
}
