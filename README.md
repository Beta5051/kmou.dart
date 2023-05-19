# kmou.dart
한국해양대학교 공지사항, 학식, 학사일정 조회 라이브러리

## Usage
```yaml
dependencies:
  kmou:
    git: https://github.com/Beta5051/kmou.dart.git
```

```dart
import 'package:kmou/kmou.dart';

void main() async {
    final kmou = KmouClient();

    final schedule = kmou.getSchedule();

    print(schedule);
}
```