import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedIndex;

    return BottomNavigationBar(
      onTap: (int index) => uiProvider.selectedIndex = index,
      elevation: 0,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.location_pin), 
          label : 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.link_rounded), 
          label : 'Addresses',
        ),
      ]
    );
  }
}