import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  const Calendar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      color: Colors.grey.shade200,
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      locale: 'ko_KR', // 언어 설정 (이것 이용 위해 main.dart에서 추가적인 작업함)
      focusedDay: focusedDay,
      firstDay: DateTime(1800), // 1800년도 부터 고를 수 있음
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false, // 헤더 맨오른쪽의 '2week'없애줌
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      calendarStyle: CalendarStyle(
        // 오늘날짜 highlight 제거
        isTodayHighlighted: false,
        // 각 날짜(day)(주중)들이 하나의 작은 Container안에 들어있음. 그 Container를 decorate.
        defaultDecoration: defaultBoxDeco,
        // 주말은 주중과 따로 Decorate 해야됨
        weekendDecoration: defaultBoxDeco,
        // 선택된 날짜 Decorate
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          // 테두리
          border: Border.all(
            width: 1,
            color: PRIMARY_COLOR,
          ),
        ),
        outsideDecoration: const BoxDecoration(
          // 이전, 혹은 다음달의 day를 누를때 error나는 것을 방지(rectangle로 바꿔줌)
          shape: BoxShape.rectangle,
        ),
        // 주중 날짜들의 기본 TextStyle
        defaultTextStyle: defaultTextStyle,
        // 주말 날짜들의 기본 TextStyle
        weekendTextStyle: defaultTextStyle,
        // 선택된 날짜의 기본 TextStyle
        selectedTextStyle: defaultTextStyle.copyWith(
          color: PRIMARY_COLOR,
        ),
      ),
      // 날짜 선택
      onDaySelected: onDaySelected,
      // 어떤 선택된 날짜가 marked 되게 하기위해
      selectedDayPredicate: (day) {
        if (selectedDay == null) {
          return false;
        }
        return day.year == selectedDay!.year &&
            day.month == selectedDay!.month &&
            day.day == selectedDay!.day;
      },
    );
  }
}
