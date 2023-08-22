import 'package:drift/drift.dart';

/// 7개의 column
/// drift가 알아서 sqllite와 소통해서 밑의 구조대로 schedules로 만들어줌
class Schedules extends Table {
  // ID, CONTENT, DATE, STARTTIME, ENDTIME, COLORID, CREATEDAT

  // *PRIMARY KEY
  // autoIncrement : insert할때 ID쓸 필요 없이 자동으로 ID를 넣어줌(자동으로 1씩 올라가면서)
  IntColumn get id => integer().autoIncrement()();

  // *내용
  TextColumn get content => text()();

  // *일정 날짜
  DateTimeColumn get date => dateTime()();

  // *시작 시간
  IntColumn get startTime => integer()();

  // *끝 시간
  IntColumn get endTime => integer()();

  // *Category Color Table ID
  IntColumn get colorID => integer()();

  // *생성날짜 (항상 DateTime.now() 일 것임)
  // insert 하는 순간 시간 인식
  // default이기 때문에 dateTime을 따로 지정해서 넣어줄 수도 있음
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
      )();
}
