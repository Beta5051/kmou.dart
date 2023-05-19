import 'package:html/dom.dart';
import '../kmou_client.dart';

enum MealType {
  student, // 학생식당
  snack, // 스낵코너
  staff, // 교직원 식당
}

class Meal {
  const Meal({
    required this.type,
    required this.data,
  });

  final MealType type;
  final Map<String, String?> data;

  factory Meal.fromElement(MealType type, Element element) {
    final kinds = element
        .getElementsByTagName('thead')[0]
        .getElementsByTagName('th')
        .map((e) => e.innerHtml)
        .toList();

    final values = element
        .getElementsByTagName('tbody')[0]
        .getElementsByTagName('td')
        .map(
          (e) => e.innerHtml
              .trim()
              .replaceAll('&nbsp;', ' ')
              .replaceAll('<br>', ''),
        )
        .toList();

    return Meal(
      type: type,
      data: {
        for (var i = 0; i < kinds.length; i++)
          kinds[i]: values.length < kinds.length
              ? null
              : values[i].isEmpty
                  ? values[i - 1]
                  : values[i],
      },
    );
  }

  @override
  String toString() => '$runtimeType(type: $type, data: $data)';
}

class BadaroMeal {
  const BadaroMeal({
    required this.title,
    required this.uri,
    required this.imageUri,
  });

  final String title;
  final Uri uri;
  final Uri? imageUri;

  factory BadaroMeal.fromElement(Element element) {
    final imgs = element.getElementsByTagName('img');

    return BadaroMeal(
      title: element.getElementsByTagName('p')[0].innerHtml,
      uri: Uri.parse(KmouClient.baseUrl + element.attributes['href']!),
      imageUri: imgs.isNotEmpty
          ? Uri.parse(KmouClient.baseUrl + imgs[0].attributes['src']!)
          : null,
    );
  }

  @override
  String toString() =>
      '$runtimeType(title: $title, uri: $uri, imageUri: $imageUri)';
}
