import 'package:flutter/material.dart';
import 'package:hormoniousflo/data/controller/phase_controller.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';
import 'package:hormoniousflo/data/models/phase_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileCalenderView extends StatelessWidget {
  const ProfileCalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PhaseController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
              child: Column(
                children: [
                  buildPhaseHeader(controller),
                  TableCalendar(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: controller.focusedDay,
                    calendarFormat: controller.calenderFormat,
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.twoWeeks: 'Week View',
                      CalendarFormat.week: '2 Weeks'
                    },
                    eventLoader: controller.getEventsForDay,
                    calendarBuilders: CalendarBuilders<PhaseModel>(
                      markerBuilder: (BuildContext context, date, events) {
                        if (events.isEmpty) return const SizedBox();
                        return Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            height: 1.5,
                            width: 30,
                            decoration: BoxDecoration(
                              color: events.first.phaseColor,
                            ),
                          ),
                        );
                      },
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        color: Colors.grey[700],
                      ),
                      weekendStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        color: Colors.grey[600],
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: kBlueGreyColor,
                      ),
                      leftChevronMargin: EdgeInsets.symmetric(horizontal: 4.0),
                      formatButtonTextStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kBlueGreyColor,
                      ),
                      formatButtonPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                        todayTextStyle: const TextStyle(
                          color: kAppColor,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                          fontSize: 16,
                        ),
                        todayDecoration: const BoxDecoration(),
                        defaultTextStyle: const TextStyle(
                          color: kAppColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: -1,
                        ),
                        weekendTextStyle: TextStyle(
                          color: Colors.grey[600]!,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        outsideTextStyle: const TextStyle(
                          color: Color(0xFFAEAEAE),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        )),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(controller.selectedDay, selectedDay)) {
                        controller.onDaySelected(selectedDay, focusedDay);
                      }
                    },
                    onFormatChanged: controller.onFormatChange,
                    onPageChanged: controller.onPageChanged,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildPhaseHeader(PhaseController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: 'Current Phase: ',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              color: kBlueGreyColor,
            ),
            children: [
              TextSpan(
                text: controller.getEventsForDay(kToday).isNotEmpty
                    ? controller.getEventsForDay(kToday).first.phase
                    : 'No Phase',
                style: TextStyle(
                  fontSize: 17,
                  letterSpacing: -1,
                  fontWeight: FontWeight.bold,
                  color: controller.getEventsForDay(kToday).isNotEmpty
                      ? controller.getEventsForDay(kToday).first.phaseColor
                      : kAppColor,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.info_outline,
          color: kBlueGreyColor,
          size: 19,
        ),
      ],
    );
  }
}
