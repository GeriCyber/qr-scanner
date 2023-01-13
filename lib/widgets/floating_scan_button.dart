import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class FloatingScanButton extends StatefulWidget {
  const FloatingScanButton({super.key});

  @override
  State<FloatingScanButton> createState() => _FloatingScanButtonState();
}

class _FloatingScanButtonState extends State<FloatingScanButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {  
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF', 
          'Cancel', 
          false, 
          ScanMode.QR);
          if(barcodeScanRes == '-1') {
            return;
          } else if(mounted) {
            final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
            final newScan = await scanListProvider.newScan(barcodeScanRes);
            launchUrl(context, newScan);
          }
      },
      child: const Icon(Icons.filter_center_focus_rounded),
    );
  }
}