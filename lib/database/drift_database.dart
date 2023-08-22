// private 값들은 불러올 수 없다.
import 'dart:io';
import 'package:drift/native.dart';

import 'package:calendar_scheduler/model/category_color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// private 값까지 불러올 수 있다.
// 현재 파일이름(drift_database)에다가 .g.dart 까지 포함해서 'part'로 포함시키면됨
part 'drift_database.g.dart';

/// * flutter pub run build_runner build
/// 모든 code generation을 해주는 모든 패키지가 이 코드를 씀 그냥 암기 ***

@DriftDatabase(
  // 어떤 클래스들을 table로 쓸지
  tables: [
    Schedules,
    CategoryColors,
  ],
)

// 우리가 사용할 database의 이름 어떻게든 짓고(LocalDatabase)
// 그 이름을 그대로 본따서 extends 해줌 (_$ 이용) (drift에서 class이름을 보고서 만들어줌)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  // 생성
  // schedules에 data insert
  // SchedulesCompanion은 ~.g.dart에 있음
  // 'schedules'가 소문자로 시작함 -> 이것도 ~.g.dart에
  // 자동으로 id (primary key값)을 return 받을 수 있으므로 Future<int> 해줌 (insert한 값의 primary key)
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColors(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  // CategoryColors 가져오기
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  // 데이터베이스에 설정한 테이블들의 상태 (1부터 시작)
  @override
  int get schemaVersion => 1;
}

/// 실제 우리가 database 파일을 어떤 위치에 생성시킬것인지
/// 하드드라이브의 어느 위치에 저장할지 우리가 명시해줘야함
/// (연결을 열어라)
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // database를 저장할 폴더 (앱 전용으로 사용할 수 있는 폴더)
    // getApplicationDocumentsDirectory : OS에서 앱별로 사용할 수 있는 하드드라이브의 특정위치들을 지정해줌 (import 'package:path_provider/path_provider.dart';)
    final dbFolder = await getApplicationDocumentsDirectory();
    // database 정보 저장할 파일
    final file = File(p.join(
      dbFolder.path, // dbFolder의 경로
      'db.sqlite', // 원하는 이름으로 지정(경로에다가 db.sqlite라는 파일을 생성한 것임)
    ));
    // 위에서 만든 파일로 database를 만들어라
    return NativeDatabase(file); // native.dart 패키지 import 해야됨
  });
}
