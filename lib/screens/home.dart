import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/addresses.dart';
import 'package:qr_reader/screens/maps.dart';

import '../widgets/floating_scan_button.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Provider.of<ScanListProvider>(context, listen: false).deleteAll();
          }, icon: Icon(Icons.delete_forever))
        ],
        title: Text('History'),
        elevation: 0,
      ),
      body: _HomeBody(),
      bottomNavigationBar: NavBar(),
      floatingActionButton: FloatingScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final index = uiProvider.selectedIndex;
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch(index) {
      case 0: 
        scanListProvider.loadScanByType('geo');
        return MapsScreen();
      case 1:
        scanListProvider.loadScanByType('http');
        return AddressesScreen();
      default:
        // scanListProvider.loadScanByType('geo');
        return MapsScreen();
    }
  }
}