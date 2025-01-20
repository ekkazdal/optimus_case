// To parse this JSON data, do
//
//     final regionZones = regionZonesFromJson(jsonString);

import 'dart:convert';

RegionZones regionZonesFromJson(String str) => RegionZones.fromJson(json.decode(str));

String regionZonesToJson(RegionZones data) => json.encode(data.toJson());

class RegionZones {
  List<RegionZone>? regionZone;

  RegionZones({
    this.regionZone,
  });

  factory RegionZones.fromJson(Map<String, dynamic> json) => RegionZones(
        regionZone: List<RegionZone>.from(json["region_zone"].map((x) => RegionZone.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "region_zone": List<dynamic>.from(regionZone!.map((x) => x.toJson())),
      };
}

class RegionZone {
  String? zone;
  String? utc;
  String? utcDst;
  double? utcV;
  double? utcDstV;

  RegionZone({
    this.zone,
    this.utc,
    this.utcDst,
    this.utcV,
    this.utcDstV,
  });

  factory RegionZone.fromJson(Map<String, dynamic> json) => RegionZone(
        zone: json["zone"],
        utc: json["utc"],
        utcDst: json["utc_dst"],
        utcV: json["utc_v"].toDouble(),
        utcDstV: json["utc_dst_v"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "zone": zone,
        "utc": utc,
        "utc_dst": utcDst,
        "utc_v": utcV,
        "utc_dst_v": utcDstV,
      };
}
