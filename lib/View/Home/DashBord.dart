import 'package:attendence_mangement_system/Data/Models/AttendanceModel.dart';
import 'package:attendence_mangement_system/Services/DataBaseServices/DataControllers/GetDataController.dart';
import 'package:attendence_mangement_system/Utils/Constants/Constants.dart';
import 'package:attendence_mangement_system/Utils/Themes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DashBord extends ConsumerStatefulWidget {
  const DashBord({Key? key, required this.model}) : super(key: key);
  final AttendanceModel model;

  @override
  ConsumerState<DashBord> createState() => _DashBordState();
}

class _DashBordState extends ConsumerState<DashBord> {
  late final AttendanceModel model;
  final now = DateTime.now();
  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(fullAttendnceFutureProvider(model));
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: const [],
        ),
        body: data.when(
          data: (data) {
            final filter = _getFilterList(data);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(
                    'ATTENDANCE  DETAILS',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'DATE }',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: primaryColor),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        'PRESENT',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: primaryColor),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: filter.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  filter[index].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: primaryColor),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'absent',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(color: Colors.green),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          },
          error: (error, s) => const Center(
            child: Text('error'),
          ),
          loading: () => const Center(
            child: CupertinoActivityIndicator(),
          ),
        ));
  }

  List<int> _getFilterList(List<AttendanceModel> data) {
    late final Set<int> filter;
    final filterData = data
        .map((e) =>
            DateTime.fromMillisecondsSinceEpoch(int.parse(e.dateTime)).day)
        .toList()
        .where((element) => Const.listOfMonths.contains(element))
        .toList();
    filter = Const.listOfMonths
        .where((element) => !filterData.contains(element))
        .toSet();

    filter.addAll(filterData);
    filter.toList().sort();
    final minList = (filterData + filter.toList());
    minList.sort();
    minList.toSet();
    return minList.toList();
  }
}
