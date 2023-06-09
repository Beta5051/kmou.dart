import 'package:html/dom.dart';
import '../kmou_client.dart';

class Notice {
  const Notice({
    required this.isEmphaized,
    required this.title,
    required this.url,
    required this.createdAt,
  });

  final bool isEmphaized;
  final String title;
  final String url;
  final DateTime createdAt;

  factory Notice.fromElement(Element element) {
    final tds = element.getElementsByTagName('td');

    return Notice(
      isEmphaized: tds[0].innerHtml.contains('공지'),
      title: tds[1].getElementsByTagName('a')[0].innerHtml.trim(),
      url: KmouClient.baseUrl +
          tds[1].getElementsByTagName('a')[0].attributes['href']!,
      createdAt: DateTime.parse(tds[3].innerHtml.replaceAll('.', '')),
    );
  }

  @override
  String toString() =>
      'Notice(isEmphaized: $isEmphaized, title: $title, url: $url, createdAt: $createdAt)';
}
