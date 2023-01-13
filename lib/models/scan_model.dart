import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel? scanModelFromMap(String str) => ScanModel.fromMap(json.decode(str));

String scanModelToMap(ScanModel? data) => json.encode(data!.toMap());

class ScanModel {
    ScanModel({
        this.id,
        this.type,
        @required this.value,
    }) {
        if(value!.contains('http')) {
          type = 'http';
        } else {
          type = 'geo';
        }
    }

    int? id;
    String? type;
    String? value;

    LatLng getLatLng() {
      final endPattern = value!.indexOf('?');
      final latLng = value!.substring(4, endPattern).split(',');
      print(latLng);
      final latitude = double.parse(latLng[0]);
      final longitude = double.parse(latLng[1]);
      return LatLng(latitude, longitude);
    }

    factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "value": value,
    };
}
