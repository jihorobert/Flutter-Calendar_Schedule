import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(), // floating button
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            const SizedBox(height: 8),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 3,
            ),
            const SizedBox(height: 8),
            const _ScheduleList(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // 화면이 밑에서부터 올라옴
        // showModalBottomSheet 의 기본 최대크기 : 화면의 반 -> isScrollControlled 로 전체화면 되게
        // 즉 키보드의 크기를 고려한 bottomSheet 를 만들 수 있음
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            // 나타나는 화면
            return const ScheduleBottomSheet();
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    //print(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // List가 얼만큼의 사이즈를 차지해야되는지 모르기 때문에
        // 남는 나머지의 공간을 차지하라고 Expanded 이용. (Scrolling도 됨)
        child: ListView.separated(
          /// itemCount 개수 만큼 한번에 화면에 렌더링이 되는것이 아니고
          /// Scroll하면서 화면에 보여지는 것들 만큼 렌더링 됨.
          /// 즉, ScheduleCard가 미리 다 그려지는 것이 아니라 그려질 순서가 되면 그려짐.
          itemCount: 100, // 리스트에 몇개를 보여줄건지
          /// separatorBuilder : itemBuilder가 일어나고 그 이후에 일어남.
          /// 각각의 item 사이에 들어갈 위젯을 정의.(여기서는 ScheduleCard들 사이사이에 들어갈 위젯들)
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 8,
            );
          },
          itemBuilder: (context, index) {
            // print(index);
            // index : 몇번째
            return ScheduleCard(
              startTime: 12,
              endTime: 3,
              content: '프로그래밍 공부하기 $index',
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
