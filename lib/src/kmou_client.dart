import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'base_client.dart';
import 'models/models.dart';

class KmouClient extends BaseClient {
  static const baseUrl = 'https://www.kmou.ac.kr';

  KmouClient({http.Client? httpClient})
      : super(
          baseUrl: baseUrl,
          httpClient: httpClient,
        );

  Future<List<Notice>> getNotices({
    int page = 1,
    bool removeEmphaized = true,
  }) =>
      send(
        'POST',
        '/kmou/na/ntt/selectNttList.do',
        mi: 2032,
        bbsId: 10373,
        params: {'currPage': page},
      ).then(
        (document) => document
            .getElementsByClassName('BD_list')[0]
            .getElementsByTagName('tbody')[0]
            .getElementsByTagName('tr')
            .map((item) => Notice.fromElement(item))
            .where((notice) => !removeEmphaized || !notice.isEmphaized)
            .toList(),
      );

  Future<List<Meal>> getMeals(DateTime date) => send(
        'POST',
        '/coop/dv/dietView/selectDietDateView.do',
        params: {
          'sch_date': DateFormat('yyyy/MM/dd').format(date),
        },
      ).then(
        (document) => document
            .getElementById('dietAddView')!
            .getElementsByClassName('BD_table')
            .asMap()
            .map(
              (idx, element) => MapEntry(
                idx,
                Meal.fromElement(
                  MealType.values[idx],
                  element,
                ),
              ),
            )
            .values
            .toList(),
      );

  Future<Schedule> getSchedule() => send(
        'GET',
        '/onestop/cm/cntnts/cntntsView.do',
        mi: 74,
        params: {'cntntsId': 1755},
      ).then(
        (document) => Schedule.fromElement(document
            .getElementById('cntntsView')!
            .getElementsByTagName('div')[1]),
      );

  Future<List<Notice>> getBadaroNotices({
    int page = 1,
    bool removeEmphaized = true,
  }) =>
      send(
        'POST',
        '/badaro/na/ntt/selectNttList.do',
        mi: 4366,
        bbsId: 10003004,
        params: {'currPage': page},
      ).then(
        (document) => document
            .getElementsByClassName('BD_list')[0]
            .getElementsByTagName('tbody')[0]
            .getElementsByTagName('tr')
            .map((item) => Notice.fromElement(item))
            .where((notice) => !removeEmphaized || !notice.isEmphaized)
            .toList(),
      );

  Future<List<BadaroMeal>> getBadaroMeals([int page = 1]) => send(
        'POST',
        '/badaro/na/ntt/selectNttList.do',
        mi: 4373,
        bbsId: 10003043,
        params: {'currPage': page},
      ).then(
        (document) => document
            .getElementsByClassName('photo_list')[0]
            .getElementsByTagName('a')
            .map((item) => BadaroMeal.fromElement(item))
            .toList(),
      );
}
