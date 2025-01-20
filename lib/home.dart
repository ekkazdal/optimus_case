import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:optimus_case/detail/detail_page.dart';
import 'package:optimus_case/util/dimen.dart';
import 'package:optimus_case/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          body: SizedBox(
            height: double.maxFinite,
            child: Stack(
              children: [
                Container(
                  width: Dimen.widthFactor * 100,
                  height: Dimen.widthFactor * 47,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                    color: Theme.of(context).cardColor,
                  ),
                  padding: EdgeInsets.only(top: Dimen.widthFactor * 15).copyWith(left: 36, right: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Günaydın, Özgür!',
                        style: TextStyle(color: Theme.of(context).hintColor, fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat('HH : mm').format(DateTime.now()).toString(),
                        style: TextStyle(color: Theme.of(context).hintColor, fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat('d MMMM, EEEE').format(DateTime.now()).toString(),
                        style: TextStyle(color: Theme.of(context).hintColor, fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: Dimen.widthFactor * 10,
                  top: Dimen.widthFactor * 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).focusColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400, width: 2),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Theme.of(context).brightness == Brightness.dark ? SvgPicture.asset("assets/image/moon.svg") : SvgPicture.asset("assets/image/sun.svg"),
                  ),
                ),
                Positioned(
                  top: Dimen.widthFactor * 32,
                  child: Padding(
                    padding: const EdgeInsets.all(36),
                    child: SizedBox(
                      width: Dimen.widthFactor * 80,
                      height: Dimen.widthFactor * 12,
                      child: SearchBar(
                        hintText: "Arama",
                        leading: const Icon(Icons.search, size: 20, color: Colors.black),
                        textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16)),
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        elevation: WidgetStateProperty.all(0),
                        hintStyle: WidgetStateProperty.all(const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 16)),
                        onChanged: (value) => viewModel.searchBar(value),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Dimen.widthFactor * 55,
                  child: SizedBox(
                    width: Dimen.widthFactor * 100,
                    height: Dimen.widthFactor * 450,
                    child: ListView.builder(
                      itemCount: viewModel.filterRegionZoneResponse?.regionZone?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(regionZone: viewModel.filterRegionZoneResponse!.regionZone![index])));
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  child: Container(
                                    width: Dimen.widthFactor * 80,
                                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      viewModel.filterRegionZoneResponse!.regionZone![index].zone!,
                                      style: TextStyle(color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Theme.of(context).hintColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
