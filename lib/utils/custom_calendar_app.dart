import 'package:flutter/material.dart';
import 'package:hrms_task/utils/custom_validation.dart';
import 'package:hrms_task/utils/hrms_colors.dart';
import 'package:intl/intl.dart';

class CustomCalendarApp extends StatefulWidget {
  final List<dynamic> allTaskList;
  final CalendarViews currentView;
  final Function(DateTime)? onDateChange;

  CustomCalendarApp(this.allTaskList, {this.currentView = CalendarViews.month, this.onDateChange, Key? key}) : super(key: key);

  @override
  _CustomCalendarAppState createState() => _CustomCalendarAppState();
}

class _CustomCalendarAppState extends State<CustomCalendarApp> {
  // number of days in month [JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC]
  final List<int> _monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  /*final List<String> _dayTime = List<String>.generate(
      24,
      (index) => index < 11
          ? (index + 1).toString() + " AM"
          : index == 11
              ? "12 PM"
              : index == 23
                  ? "12 AM"
                  : (index - 11).toString() + " PM");*/

  DateTime _currentDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<Calendar> _sequentialDates = [];
  int _currentWeekPos = 0;
  int _currentDayPos = 0;
  int midYear = DateTime.now().year;
  List<String> _weekDays = [];
  List<String> _monthNames = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.currentView == CalendarViews.week) {
          setState(
            () {
              _currentWeekPos = 0;
              _currentDayPos = 0;
              for (int i = 0; i < _sequentialDates.length; i++) {
                if (_sequentialDates[i].date!.month == DateTime.now().month &&
                    _sequentialDates[i].date!.isSameDate(
                          DateTime.now(),
                        )) {
                  _currentWeekPos = (i / 7).floor() * 7;
                  break;
                }
              }
            },
          );
          debugPrint(
            "_currentWeekPos : " + _currentWeekPos.toString(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // debugPrint(width.toString(),);
    _weekDays = [
      "Sun",
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat"
    ];

    _monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return Container(
      decoration: widget.currentView == CalendarViews.week
          ? BoxDecoration()
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
      padding: widget.currentView == CalendarViews.week ? EdgeInsets.zero : EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // header
          if (widget.currentView != CalendarViews.week)
            Row(
              children: <Widget>[
                Spacer(),
                // prev month button
                _toggleBtn(false),
                // month and year
                Container(
                  width: 160,
                  child: Center(
                    child: Text(
                      '${_monthNames[_currentDateTime.month - 1]} ${_currentDateTime.year}',
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ),
                ),
                // next month button
                _toggleBtn(true),
                Spacer(),
              ],
            ),
          if (widget.currentView == CalendarViews.month)
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: _weekDayTitle(),
            ),
          if (widget.currentView == CalendarViews.month)
            Flexible(
              child: _calendarBodyMonth(),
            ),
          if (widget.currentView == CalendarViews.week)
            Flexible(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return _calendarBodyWeek(constraints);
                },
              ),
            ),
        ],
      ),
    );
  }

  // calendar month
  Widget _calendarBodyMonth() {
    _getCalendar();
    // if (_sequentialDates == null) return Container();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 15, bottom: 2),
      itemCount: _sequentialDates.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.3, crossAxisCount: 7, crossAxisSpacing: 5, mainAxisSpacing: 5),
      itemBuilder: (context, index) {
        // if (_sequentialDates[index].date == _selectedDateTime) return _selector(_sequentialDates[index], index);
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return _calendarDates(_sequentialDates[index], index, constraints);
          },
        );
      },
    );
  }

  // calendar week
  Widget _calendarBodyWeek(BoxConstraints mainConstraints) {
    _getCalendar();
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: List.generate(
              7,
              (index) => _calendarWeekDayTitle(_sequentialDates[_currentWeekPos + index], mainConstraints),
            ),
          ),
        ],
      ),
    );
  }

  // calendar header month
  Widget _weekDayTitle() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3,
        crossAxisCount: 7,
      ),
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            _weekDays[index],
            style: TextStyle(color: textColor, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  Widget _calendarDates(Calendar calendarDate, int index, BoxConstraints constraints) {
    // debugPrint ("Grid width  : "+constraints.maxWidth.toString(),);
    // debugPrint ("Grid height  : "+constraints.maxHeight.toString(),);
    return InkWell(
      onTap: () {
        if (calendarDate.allTaskList!.isNotEmpty) showTaskListDialog(calendarDate.allTaskList!);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: _sequentialDates[index].allTaskList!.length > 0 ? Color(0xFFFFB400) : Colors.transparent,
              width: _sequentialDates[index].allTaskList!.length > 0 ? 2 : 0),
          color: _sequentialDates[index].allTaskList!.length > 0
              ? Color(0xFFFFB400).withOpacity(0.5)
              : Colors.white,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '${calendarDate.date!.day}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Bold',
            color: (calendarDate.thisMonth)
                ? (calendarDate.date!.weekday == DateTime.sunday)
                    ? textColor
                    : textColor
                : (calendarDate.date!.weekday == DateTime.sunday)
                    ? dividerColor
                    : textColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _calendarWeekDayTitle(Calendar calendarDate, BoxConstraints mainConstrain) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blueGrey,
        onTap: () {
          if (widget.onDateChange != null) {
            setState(
              () {
                _selectedDateTime = calendarDate.date!;
              },
            );
            widget.onDateChange!(_selectedDateTime);
          }
        },
        child: Container(
          /*decoration: BoxDecoration(
                border: Border.all(color: calendar_border, width: 1),
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(0),),),*/
          width: (mainConstrain.maxWidth) / 7,
          // width: constraints.maxWidth /7,
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('EE', "en").format(calendarDate.date!).allInCaps,
                style: TextStyle(
                  color: calendarDate.date == _selectedDateTime ? selectedCalendarBorder.withOpacity(0.7) : textLow,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, top: 2),
                child: Text(
                  '${calendarDate.date!.day}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: (calendarDate.thisMonth)
                        ? (calendarDate.date!.weekday == DateTime.sunday)
                            ? textColor
                            : calendarDate.date == _selectedDateTime
                                ? selectedCalendarBorder
                                : textColor
                        : (calendarDate.date!.weekday == DateTime.sunday)
                            ? previousDate
                            : textColor.withOpacity(0.5),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 2,
                    margin: EdgeInsets.only(top: 4),
                    color: divider,
                  ),
                  if (calendarDate.date == _selectedDateTime)
                    Container(
                      height: 2,
                      margin: EdgeInsets.only(top: 4, left: 7, right: 7),
                      color: selectedCalendarBorder,
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleBtn(bool next) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        splashColor: rippleColor,
        onTap: () {
          if (widget.currentView == CalendarViews.month) {
            setState(
              () => (next) ? _getNextMonth() : _getPrevMonth(),
            );
          } else if (widget.currentView == CalendarViews.week) {
            if (next) {
              int tempWeekPos = _currentWeekPos + 7;
              debugPrint(
                "tempWeekPos : " + tempWeekPos.toString(),
              );
              debugPrint(
                "_sequentialDates.length : " + _sequentialDates.length.toString(),
              );
              if (tempWeekPos >= _sequentialDates.length) {
                _currentWeekPos = 0;
                _getNextMonth();
              } else {
                _currentWeekPos = tempWeekPos;
              }
            } else {
              int tempWeekPos = _currentWeekPos - 7;
              debugPrint(
                "tempWeekPos : " + tempWeekPos.toString(),
              );
              debugPrint(
                "_sequentialDates.length : " + _sequentialDates.length.toString(),
              );
              if (tempWeekPos < 0) {
                _currentWeekPos = 0;
                _getPrevMonth();
                _getCalendar();
                _currentWeekPos = (_sequentialDates.length - 7);
              } else {
                _currentWeekPos = tempWeekPos;
              }
            }
            setState(
              () {},
            );
          } else if (widget.currentView == CalendarViews.day) {
            if (next) {
              int tempDayPos = _currentDayPos + 1;
              debugPrint(
                "_tempDayPos : " + tempDayPos.toString(),
              );
              debugPrint(
                "_sequentialDates.length : " + _sequentialDates.length.toString(),
              );
              if (tempDayPos >= _sequentialDates.length || _sequentialDates[tempDayPos].nextMonth || _sequentialDates[tempDayPos].prevMonth) {
                _currentDayPos = 0;
                _getNextMonth();
                _getCalendar();
                for (int i = 0; i < _sequentialDates.length; i++) {
                  if (_sequentialDates[i].thisMonth) {
                    _currentDayPos = i;
                    break;
                  }
                }
              } else {
                _currentDayPos = tempDayPos;
              }
            } else {
              int tempDayPos = _currentDayPos - 1;
              debugPrint(
                "_tempDayPos : " + tempDayPos.toString(),
              );
              debugPrint(
                "_sequentialDates.length : " + _sequentialDates.length.toString(),
              );
              if (tempDayPos < 0 || _sequentialDates[tempDayPos].nextMonth || _sequentialDates[tempDayPos].prevMonth) {
                _currentDayPos = 0;
                _getPrevMonth();
                _getCalendar();
                for (int i = (_sequentialDates.length - 1); i >= 0; i--) {
                  if (_sequentialDates[i].thisMonth) {
                    _currentDayPos = i;
                    break;
                  }
                }
              } else {
                _currentDayPos = tempDayPos;
              }
            }
            setState(
              () {},
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 25,
          height: 25,
          child: Icon(
            (next) ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_rounded,
            size: 18,
            color: textColor,
          ),
        ),
      ),
    );
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime = DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    // _getCalendar();
  }

  // get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime = DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    // _getCalendar();
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = getMonthCalendar(_currentDateTime.month, _currentDateTime.year, startWeekDay: StartWeekDay.sunday);
  }

  bool _isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) return true;
        return false;
      }
      return true;
    }
    return false;
  }

  /// get the month calendar
  /// month is between from 1-12 (1 for January and 12 for December)
  List<Calendar> getMonthCalendar(int month, int year, {StartWeekDay startWeekDay = StartWeekDay.sunday}) {
    // validate
    if (month < 1 || month > 12) throw ArgumentError('Invalid year or month');

    List<Calendar> calendar = [];

    // used for previous and next month's calendar days
    int otherYear;
    int otherMonth;
    int leftDays;

    // get no. of days in the month
    // month-1 because _monthDays starts from index 0 and month starts from 1
    int totalDays = _monthDays[month - 1];
    // if this is a leap year and the month is february, increment the total days by 1
    if (_isLeapYear(year) && month == DateTime.february) totalDays++;

    // get this month's calendar days
    for (int i = 0; i < totalDays; i++) {
      DateTime currentDate = DateTime(year, month, i + 1);
      List<dynamic> tempTaskList = [];

      for (var tempTaskItem in widget.allTaskList) {
        if (tempTaskItem.dueDate != null &&
            ((tempTaskItem.isRecurring != null && tempTaskItem.isRecurring! && tempTaskItem.createdAt != null)
                ? currentDate.isSameDate(
                    DateTime.parse(tempTaskItem.createdAt!),
                  )
                : currentDate.isSameDate(
                    DateTime.parse(tempTaskItem.dueDate!),
                  ))) {
          tempTaskList.add(tempTaskItem);
        }
      }
      calendar.add(
        Calendar(
            // i+1 because day starts from 1 in DateTime class
            date: currentDate,
            thisMonth: true,
            allTaskList: tempTaskList),
      );
    }

    // fill the unfilled starting weekdays of this month with the previous month days
    if ((startWeekDay == StartWeekDay.sunday && calendar.first.date!.weekday != DateTime.sunday) ||
        (startWeekDay == StartWeekDay.monday && calendar.first.date!.weekday != DateTime.monday)) {
      // if this month is january, then previous month would be decemeber of previous year
      if (month == DateTime.january) {
        otherMonth = DateTime.december; // _monthDays index starts from 0 (11 for december)
        otherYear = year - 1;
      } else {
        otherMonth = month - 1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0 and month starts from 1
      totalDays = _monthDays[otherMonth - 1];
      if (_isLeapYear(otherYear) && otherMonth == DateTime.february) totalDays++;

      leftDays = totalDays - calendar.first.date!.weekday + ((startWeekDay == StartWeekDay.sunday) ? 0 : 1);

      for (int i = totalDays; i > leftDays; i--) {
        DateTime currentDate = DateTime(otherYear, otherMonth, i);
        List<dynamic> tempTaskList = [];

        for (var tempTaskItem in widget.allTaskList) {
          if (tempTaskItem.dueDate != null &&
              ((tempTaskItem.isRecurring != null && tempTaskItem.isRecurring! && tempTaskItem.createdAt != null)
                  ? currentDate.isSameDate(
                      DateTime.parse(tempTaskItem.createdAt!),
                    )
                  : currentDate.isSameDate(
                      DateTime.parse(tempTaskItem.dueDate!),
                    ))) {
            tempTaskList.add(tempTaskItem);
          }
        }
        calendar.insert(
          0,
          Calendar(date: currentDate, prevMonth: true, allTaskList: tempTaskList),
        );
      }
    }

    // fill the unfilled ending weekdays of this month with the next month days
    if ((startWeekDay == StartWeekDay.sunday && calendar.last.date!.weekday != DateTime.saturday) ||
        (startWeekDay == StartWeekDay.monday && calendar.last.date!.weekday != DateTime.sunday)) {
      // if this month is december, then next month would be january of next year
      if (month == DateTime.december) {
        otherMonth = DateTime.january;
        otherYear = year + 1;
      } else {
        otherMonth = month + 1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0 and month starts from 1
      totalDays = _monthDays[otherMonth - 1];
      if (_isLeapYear(otherYear) && otherMonth == DateTime.february) totalDays++;

      leftDays = 7 - calendar.last.date!.weekday - ((startWeekDay == StartWeekDay.sunday) ? 1 : 0);
      if (leftDays == -1) leftDays = 6;

      for (int i = 0; i < leftDays; i++) {
        DateTime currentDate = DateTime(otherYear, otherMonth, i + 1);
        List<dynamic> tempTaskList = [];

        for (var tempTaskItem in widget.allTaskList) {
          if (tempTaskItem.dueDate != null &&
              ((tempTaskItem.isRecurring != null && tempTaskItem.isRecurring! && tempTaskItem.createdAt != null)
                  ? currentDate.isSameDate(
                      DateTime.parse(tempTaskItem.createdAt!),
                    )
                  : currentDate.isSameDate(
                      DateTime.parse(tempTaskItem.dueDate!),
                    ))) {
            tempTaskList.add(tempTaskItem);
          }
        }
        calendar.add(
          Calendar(date: currentDate, nextMonth: true, allTaskList: tempTaskList),
        );
      }
    }

    return calendar;
  }

  void showTaskListDialog(List<dynamic> allTaskList) {

  }

  List<dynamic> getTimeWiseTaskList(List<dynamic>? taskList, int index) {
    List<dynamic> tempTaskList = [];
    if (taskList != null) {
      for (var taskItem in taskList) {
        if (DateTime.parse(taskItem.dueDate!).hour == index) tempTaskList.add(taskItem);
      }
    }
    return tempTaskList;
  }
}

class Calendar {
  final DateTime? date;
  final bool thisMonth;
  final bool prevMonth;
  final bool nextMonth;
  final List<dynamic>? allTaskList;

  Calendar({this.date, this.thisMonth = false, this.prevMonth = false, this.nextMonth = false, this.allTaskList});
}

enum CalendarViews { month, week, day }

enum StartWeekDay { sunday, monday }
