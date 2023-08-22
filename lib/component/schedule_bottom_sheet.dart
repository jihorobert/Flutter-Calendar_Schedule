import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // viewInsets : 스크린에서 시스템적인 문제때문에 가려진 화면의 크기
    // 스케쥴 입력창 나왔을때 가려진 부분의 아랫쪽(Bottom)을 가져옴
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    /// 주변 다른 화면 눌렀을때 키보드가 없어지게 하기 위해 GestureDetector 이용
    return GestureDetector(
      onTap: () {
        // 이건 그냥 외우기
        // Focus 돼있는 TextField에서 Focus 를 없앨 수 있음
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,
          // 화면 전체의 절반을 차지
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: const Padding(
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Time(),
                  SizedBox(height: 16),
                  _Content(),
                  SizedBox(height: 8),
                  _ColorPicker(),
                  SizedBox(height: 8),
                  _SaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
            isTime: true,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
            isTime: true,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    // Expanded 통해서 '내용'부분 차지 비중 늘려줌
    return const Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker();

  @override
  Widget build(BuildContext context) {
    /// * Row 대신에 Wrap 썼음.
    /// Wrap : 자동적으로 다음줄로 넘어가게 해줌(줄바꿈)
    return Wrap(
      spacing: 8, // 양옆 사이간격
      runSpacing: 10, // 위아래(Row별) 간격
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    // Row로 감싸고 Expanded로 감싸서 버튼을 늘려줌
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            child: const Text('저장'),
          ),
        ),
      ],
    );
  }
}
