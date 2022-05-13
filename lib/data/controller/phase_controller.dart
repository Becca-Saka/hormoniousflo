import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hormoniousflo/data/models/phase_model.dart';
import 'package:hormoniousflo/data/repository/phase_repository.dart';
import 'package:hormoniousflo/data/services/notification_service.dart';
import 'package:hormoniousflo/data/services/shared_preferences.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';
import 'package:hormoniousflo/ui/shared/const_messages.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 4, kToday.day);

class PhaseController extends ChangeNotifier {
  String? periodDate, periodDateFormatted;
  String? periodLength;
  String? cycleLength;
  bool isBottomSheetOpen = false;
  int selectedIndex = 0;
  List<PhaseModel> phases = [];
  DateTime focusedDay = kToday;
  CalendarFormat calenderFormat = CalendarFormat.month;
  DateTime? selectedDay;
  final PhaseRepositoy _phaseRepositoy = PhaseRepositoy();
  final SharedPrefrenceService _sharedPrefrenceService =
      SharedPrefrenceService();
  final kEvents = LinkedHashMap<DateTime, List<PhaseModel>>(
    equals: isSameDay,
  );

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    notifyListeners();
  }

  void onFormatChange(CalendarFormat format) {
    calenderFormat = format;
    notifyListeners();
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay = focusedDay;
  }

  List<PhaseModel> getEventsForDay(DateTime day) {
    final remob = DateTime(day.year, day.month, day.day);
    return kEvents[remob] ?? [];
  }

  void updatePeriodLength(String value) {
    periodLength = value;
    notifyListeners();
  }

  void updateCycleLength(String value) {
    cycleLength = value;
    notifyListeners();
  }

  void toggleBottomSheet() {
    isBottomSheetOpen = !isBottomSheetOpen;
    notifyListeners();
  }

  void selectDate(BuildContext context) async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2015),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kBlueColour,
              onPrimary: kAppColor,
              onSurface: kAppColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kAppColor,
                onSurface: kAppColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      periodDate = DateFormat('MMMM d, yyyy').format(picked);
      periodDateFormatted = DateFormat('MM-d-yyyy').format(picked);
      notifyListeners();
    }
  }

  Future<void> getCycleInfo(BuildContext context) async {
    if (periodDate != null || periodLength != null || cycleLength != null) {
      toggleBottomSheet();
      AppAlert.loadingButtomSheet(context);
      final response = await _phaseRepositoy.getPhases(
          periodDate!, periodLength!, cycleLength!);
      if (response.isSuccessful) {
        phases = parseData(response.data);
        await getPhaseEvents();

        Navigator.pop(context);
        toggleBottomSheet();
        Navigator.pop(context);

        schduleNotification();
      } else {
        toggleBottomSheet();
        AppAlert.errorButtomSheet(
          context,
          response.message!,
        );
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 900));
      }
    } else {
      AppAlert.errorButtomSheet(context, 'Please fill all the fields');
      await Future.delayed(const Duration(milliseconds: 900));
      Navigator.pop(context);
    }
  }

  /// Adds phase events to the calendar and saves them to the local storage
  Future<void> getPhaseEvents() async {
    kEvents.clear();
    for (var item in phases) {
      final date = DateTime.parse(item.startDate!);
      kEvents.addAll({
        date: [item]
      });
    }
    final mappedData = phases.map((e) => e.toJson()).toList();
    _sharedPrefrenceService.saveCycleDate(mappedData);
    notifyListeners();
  }

  void schduleNotification() {
    NotificationService.clearAllNotifications();
    final startdates = getFirstDayOfEvents();
    for (var phase in startdates) {
      final date = DateTime.parse(phase.startDate!);
      if (date.isAfter(kToday)) {
        NotificationService.scheduleNotification(
          id: UniqueKey().hashCode,
          title: 'Welcome to ${phase.phase}',
          body: ' Do you support this phase with nutrition?',
          scheduledDate: date.add(const Duration(hours: 4)),
        );
      }
    }
  }

  /// Gets first day of every phase in all cycles currently available
  /// By iterating through all phases and checking where the phase type changes
  List<PhaseModel> getFirstDayOfEvents() {
    final List<PhaseModel> startDates = [];
    late PhaseModel temp;
    for (var i = 0; i < phases.length; i++) {
      final phase = phases[i];
      if (i == 0) {
        temp = phase;
        startDates.add(phase);
      }
      if (phase.phase != temp.phase) {
        temp = phase;
        startDates.add(phase);
      }
    }
    return startDates;
  }

  /// Load cycle data from local storage using [SharedPrefrenceService]
  Future<void> getPhaseEventsFromLocal() async {
    final data = await _sharedPrefrenceService.getCycleDate();
    if (data != null) {
      phases = parseData(data);
      for (var item in phases) {
        final date = DateTime.parse(item.startDate!);
        kEvents.addAll({
          date: [item]
        });
      }
      notifyListeners();
    }
  }

  List<PhaseModel> parseData(dynamic response) {
    final responseList = response as List;
    return responseList.map((e) => PhaseModel.fromJson(e)).toList();
  }
}
