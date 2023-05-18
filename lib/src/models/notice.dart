import 'package:html/dom.dart';
import 'model_to_string.dart';
import '../kmou_client.dart';

class Notice with ModelToString {
  const Notice({
    required this.isEmphaized,
    required this.title,
    required this.uri,
    required this.createdAt,
  });

  final bool isEmphaized;
  final String title;
  final Uri uri;
  final DateTime createdAt;

  factory Notice.fromElement(Element element) {
    final tds = element.getElementsByTagName('td');

    return Notice(
      isEmphaized: tds[0].innerHtml.contains('공지'),
      title: tds[1].getElementsByTagName('a')[0].innerHtml.trim(),
      uri: Uri.parse(KmouClient.baseUrl +
          tds[1].getElementsByTagName('a')[0].attributes['href']!),
      createdAt: DateTime.parse(tds[3].innerHtml.replaceAll('.', '')),
    );
  }
}
