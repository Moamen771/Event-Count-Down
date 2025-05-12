import 'package:dio/dio.dart';
import 'package:eventcountdown/models/online_events.dart';

class ApiService {
  final dio = Dio();
  final apiKey =
      '35f58eb5c776d9be4f7e82d5bfb7983babf3be58ee3147991594d90a763edf5b';

  Future<List<OnlineEvent>> loadEvents(String title) async {
    final url =
        'https://serpapi.com/search?engine=google&q=Events+in+$title&gl=eg&api_key=$apiKey';
    final response = await dio.get(url);
    final eventsList = <OnlineEvent>[];
    for (var item in response.data['organic_results']) {
      eventsList.add(OnlineEvent.fromJson(item));
    }
    // ['title'] ['snippet'] ['favicon'] ['link']

    return eventsList;
  }
}

// main() {
//   final api = ApiService();
//   api.loadEvents('cairo');
// }
