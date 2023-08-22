import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime; // true-시간 / false-내용

  const CustomTextField({
    required this.label,
    required this.isTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextField(
      // 깜빡이는 커서 색깔
      cursorColor: Colors.grey,
      // 키보드 종류 결정('시간'입력칸일 경우와 '내용'입력칸일 경우)
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      // 최대 줄의 개수(다음 줄로 넘어감)
      // null -> 무한
      maxLines: null,
      // '내용'부분 늘려주기 위해
      // !isTime 도 가능
      expands: isTime ? false : true,
      inputFormatters: isTime
          ? [
              // 숫자 입력만 가능하기 format
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      decoration: InputDecoration(
        // 선(border) 없애줌
        border: InputBorder.none,
        // 입력창에 색깔
        filled: true,
        fillColor: Colors.grey.shade300,
      ),
    );
  }
}
