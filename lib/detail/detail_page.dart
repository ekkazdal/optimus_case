import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:optimus_case/detail/components.dart';
import 'package:optimus_case/model/region_zone.dart';
import 'package:optimus_case/util/dimen.dart';

import 'package:optimus_case/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.regionZone});

  final RegionZone? regionZone;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((values) => afterViewLoaded(context, viewModel));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      builder: (context, child) {
        viewModel = Provider.of<HomeViewModel>(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Builder(
            builder: (context) {
              if (widget.regionZone != null) {
                DateTime utc = DateTime.now().toUtc().add(Duration(hours: widget.regionZone!.utcV!.toInt()));
                return Column(
                  children: [
                    Container(
                      width: Dimen.widthFactor * 100,
                      height: Dimen.widthFactor * 26,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          Text(
                            'WORLD TIME',
                            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(width: 1)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailPageComponents().containerTime(context, widget.regionZone, DateFormat('HH').format(utc).toString()),
                          Text(':', style: TextStyle(fontSize: 79, color: Theme.of(context).hintColor, fontWeight: FontWeight.w600)),
                          DetailPageComponents().containerTime(context, widget.regionZone, DateFormat('mm').format(utc).toString()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (context) {
                              List<String> splitText = widget.regionZone!.zone!.split('/');
                              String aboveText = splitText.length > 1 ? splitText[1] : ""; // Sonrası
                              String belowText = splitText[0]; // Öncesi
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      aboveText,
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Theme.of(context).hintColor),
                                    ),
                                    Text(
                                      belowText,
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Theme.of(context).hintColor),
                                    ),
                                    SizedBox(height: Dimen.widthFactor * 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('EEEE, ').format(DateTime.now()).toString(),
                                          style: TextStyle(color: Theme.of(context).hintColor, fontSize: 18, fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          viewModel.convertTimeFormat(widget.regionZone!.utcDst!.toString()),
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Theme.of(context).hintColor),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      DateFormat('d MMMM, EEEE').format(DateTime.now()).toString(),
                                      style: TextStyle(color: Theme.of(context).hintColor, fontSize: 18, fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }

  afterViewLoaded(BuildContext context, HomeViewModel viewModel) async {
    await viewModel.readToJsonData().whenComplete(
      () {
        viewModel.filterRegionZoneResponse = viewModel.regionZoneResponse;
      },
    );
  }
}
