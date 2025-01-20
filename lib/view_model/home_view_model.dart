import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus_case/model/region_zone.dart';

class HomeViewModel extends ChangeNotifier {
  RegionZones? regionZoneResponse = RegionZones(regionZone: List.empty(growable: true));
  RegionZones? filterRegionZoneResponse = RegionZones(regionZone: List.empty(growable: true));

  Future<void> readToJsonData() async {
    regionZoneResponse?.regionZone?.clear();
    await rootBundle.loadString('assets/country.json').then((jsonStr) {
      regionZoneResponse = RegionZones.fromJson(json.decode(jsonStr));
    });
    notifyListeners();
  }

  searchBar(String query) async {
    await readToJsonData();
    filterRegionZoneResponse?.regionZone = regionZoneResponse?.regionZone?.where((element) => element.zone!.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  String convertTimeFormat(String input) {
    // Girdi en az 5 karakter uzunluğunda olmalı
    if (input.length >= 5) {
      // İşareti al (+ veya -)
      String sign = input.substring(0, 1);
      // İlk iki rakam (saat kısmı)
      String hours = input.substring(1, 3);
      // Son iki rakam (dakika kısmı)
      String minutes = input.substring(3, 5);

      // Formatlanmış çıktı
      return '$sign$hours:$minutes';
    }

    // Eğer giriş uygun değilse, olduğu gibi döndür
    return input;
  }

  String convertTimeFormast(String input) {
    // Regex ile saati ve dakikayı ayır
    final regex = RegExp(r'([+-])(\d{2})(\d{2})');
    final match = regex.firstMatch(input);

    if (match != null) {
      // İşareti, saat ve dakikayı al
      final sign = match.group(1); // + veya -
      final hours = match.group(2); // İlk iki hane (saat)
      final minutes = match.group(3); // Son iki hane (dakika)

      // Formatlanmış çıktı
      return '$sign$hours:$minutes';
    }

    // Eğer format uygun değilse, girdiği olduğu gibi döndür
    return input;
  }
}
