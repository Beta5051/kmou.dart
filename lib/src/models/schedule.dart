import 'package:html/dom.dart';
import 'model_to_string.dart';

class Schedule with ModelToString {
  const Schedule({
    required this.year,
    required this.items,
  });

  final int year;
  final List<ScheduleItem> items;

  factory Schedule.fromElement(Element element) {
    final baseYear = int.parse(
      element.getElementsByTagName('h3')[0].innerHtml.substring(0, 4),
    );

    final tbodys = element.getElementsByTagName('tbody');
    final trs = tbodys[0].getElementsByTagName('tr') +
        tbodys[1].getElementsByTagName('tr');

    int year = baseYear;

    final items = trs.map(
      (tr) {
        final dateRange = tr
            .getElementsByTagName('td')[0]
            .innerHtml
            .replaceAll(RegExp(r'\(.*?\)'), '')
            .replaceAll('’', '')
            .replaceAll(' ', '')
            .split('~')
            .map(
              (e) => (e.split('.')..removeLast())
                  .map((e) => int.parse(e))
                  .toList(),
            )
            .map((e) {
          if (e.length == 3) {
            year = 2000 + e[0];
            return DateTime(year, e[1], e[2]);
          } else {
            return DateTime(year, e[0], e[1]);
          }
        }).toList();

        return ScheduleItem(
          startDate: dateRange[0],
          endDate: dateRange.length == 2 ? dateRange[1] : null,
          content: tr.getElementsByTagName('td')[1].innerHtml,
        );
      },
    ).toList();

    return Schedule(
      year: baseYear,
      items: items,
    );
  }
}

class ScheduleItem with ModelToString {
  const ScheduleItem({
    required this.startDate,
    this.endDate,
    required this.content,
  });

  final DateTime startDate;
  final DateTime? endDate;
  final String content;
}
