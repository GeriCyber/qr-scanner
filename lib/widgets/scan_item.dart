import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/scan_list_provider.dart';

class ScanItem extends StatelessWidget {
  final String type;

  const ScanItem({required this.type});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          //TODO: add delete icon
        ),
        onDismissed: ((DismissDirection direction) => {
          Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[index].id!)
        }),
        child: ListTile(
          leading: Icon(
            type == 'http' ? Icons.link_rounded : Icons.location_on, 
            color: Theme.of(context).primaryColor
          ),
          title: Text(scans[index].value!),
          subtitle: Text(scans[index].id.toString()),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap:() => launchUrl(context, scans[index]),
        ),
      ),
    ); 
  }
}