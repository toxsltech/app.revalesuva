library horizontal_week_calendar;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalWeekCalendarr extends StatefulWidget {
  ///get DateTime on date select
  final Function(DateTime)? onDateChange;

  ///get the list of DateTime on week change
  final Function(List<DateTime>)? onWeekChange;
  final double? height;

  const HorizontalWeekCalendarr({
    super.key,
    this.onDateChange,
    this.onWeekChange,
    this.height,
  });

  @override
  State<HorizontalWeekCalendarr> createState() => _HorizontalWeekCalendarrState();
}

class _HorizontalWeekCalendarrState extends State<HorizontalWeekCalendarr> {
  CarouselController carouselController = CarouselController();

  DateTime today = DateTime(2025);

  DateTime selectedDate = DateTime.now();
  List<DateTime> currentWeek = [];
  int currentWeekIndex = 0;

  List<List<DateTime>> listOfWeeks = [];
  int selectedDateIndex = 0;

  @override
  void initState() {
    initCalender();
    super.initState();
  }

  initCalender() {
    List<DateTime> minus3Days = [];
    List<DateTime> add3Days = [];
    for (int index = 0; index < 3; index++) {
      DateTime minusDate = today.add(Duration(days: -(index + 1)));
      minus3Days.add(minusDate);
      DateTime addDate = today.add(Duration(days: (index + 1)));
      add3Days.add(addDate);
    }

    currentWeek.addAll(minus3Days.reversed.toList());
    currentWeek.add(today);
    currentWeek.addAll(add3Days);

    listOfWeeks.add(currentWeek);
    getMorePreviousWeeks();
    onDateSelect(
      DateTime.now(),
    );
    // carouselController.jumpToPage(4);
  }

  getMorePreviousWeeks() {
    List<DateTime> minus7Days = [];
    DateTime startFrom = listOfWeeks[currentWeekIndex].isEmpty ? DateTime.now() : listOfWeeks[currentWeekIndex][0];
    for (int index = 0; index < 7; index++) {
      DateTime minusDate = startFrom.add(Duration(days: -(index + 1)));
      minus7Days.add(minusDate);
    }
    listOfWeeks.add(minus7Days.reversed.toList());
    setState(() {});
    // Logger().d(listOfWeeks.length);
  }

  onDateSelect(DateTime date) {
    setState(() {
      selectedDate = date;
    });

    widget.onDateChange?.call(selectedDate);
  }

  onBackClick() {
    carouselController.nextPage();
  }

  onNextClick() {
    carouselController.previousPage();
  }

  onWeekChange(index) {
    currentWeekIndex = index;
    currentWeek = listOfWeeks[currentWeekIndex];
    if (currentWeekIndex + 1 == listOfWeeks.length) {
      getMorePreviousWeeks();
    }

    widget.onWeekChange?.call(currentWeek);
    setState(() {});
  }

  // =================

  /*isNextDisabled() {
    return listOfWeeks[currentWeekIndex].last.isBefore(DateTime.now());
  }*/

  isCurrentYear() {
    return DateFormat('yyyy').format(currentWeek[0]) == DateFormat('yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var withOfScreen = MediaQuery.of(context).size.width;

    double boxHeight = widget.height ?? withOfScreen / 2;

    return currentWeek.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      onBackClick();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('MMMM yyyy').format(
                      currentWeek[selectedDateIndex],
                    ),
                    style: theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: /*isNextDisabled()
                        ? () {*/
                        () {
                      onNextClick();
                    }
                    /*}
                        : null*/
                    ,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CarouselSlider(
                carouselController: carouselController,
                items: [
                  if (listOfWeeks.isNotEmpty)
                    for (int ind = 0; ind < listOfWeeks.length; ind++)
                      Container(
                        height: boxHeight,
                        width: withOfScreen,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            for (int weekIndex = 0; weekIndex < listOfWeeks[ind].length; weekIndex++)
                              Expanded(
                                child: GestureDetector(
                                  onTap: /*listOfWeeks[ind][weekIndex].isBefore(DateTime.now())
                                      ?*/
                                      () {
                                    onDateSelect(
                                      listOfWeeks[ind][weekIndex],
                                    );
                                    selectedDateIndex = weekIndex;
                                    setState(() {});
                                  },
                                  // : null,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: DateFormat('dd-MM-yyyy').format(listOfWeeks[ind][weekIndex]) ==
                                              DateFormat('dd-MM-yyyy').format(selectedDate)
                                          ? Colors.transparent
                                          : listOfWeeks[ind][weekIndex].isBefore(DateTime.now())
                                              ? Colors.transparent
                                              : Colors.transparent,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat(
                                            'EEE',
                                          ).format(
                                            listOfWeeks[ind][weekIndex],
                                          ),
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyLarge!.copyWith(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: DateFormat('dd-MM-yyyy').format(listOfWeeks[ind][weekIndex]) ==
                                                  DateFormat('dd-MM-yyyy').format(selectedDate)
                                              ? Colors.white
                                              : Colors.transparent,
                                          child: FittedBox(
                                            child: Text(
                                              // "$weekIndex: ${listOfWeeks[ind][weekIndex] == DateTime.now()}",
                                              "${listOfWeeks[ind][weekIndex].day}",
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.titleLarge!.copyWith(
                                                  color: DateFormat('dd-MM-yyyy').format(listOfWeeks[ind][weekIndex]) !=
                                                          DateFormat('dd-MM-yyyy').format(selectedDate)
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                ],
                options: CarouselOptions(
                  scrollPhysics: const ClampingScrollPhysics(),
                  height: boxHeight,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  reverse: true,
                  onPageChanged: (index, reason) {
                    onWeekChange(index);
                  },
                ),
              ),
            ],
          );
  }
}
