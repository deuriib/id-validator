import 'package:app/app/data/validation.model.dart';
import 'package:get/get.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.digital.gob.do';

    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return Validation.fromJson(map);
      }
    };
    httpClient.defaultContentType = 'application/json; utf-8';
  }

  Future<Response<Validation?>> validate(String id) async {
    return await get('/v3/cedulas/$id/validate');
  }
}
