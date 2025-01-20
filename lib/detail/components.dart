import 'package:flutter/material.dart';
import 'package:optimus_case/model/region_zone.dart';
import 'package:optimus_case/util/dimen.dart';

class DetailPageComponents {
  Container containerTime(BuildContext context, RegionZone? regionZone, String time) {
    return Container(
      width: Dimen.widthFactor * 38,
      height: Dimen.widthFactor * 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).cardColor : Colors.white,
        border: Border.all(color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).cardColor : Colors.black),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            fontSize: 79,
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
