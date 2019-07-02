import 'package:dio/dio.dart';
import 'package:sanbox/utils/network/network_utils.dart';

import 'middlewares/default_params_middleware.dart';
import 'middlewares/logging_middleware.dart';
import 'models/wheaters_model.dart';

class ApiService {
  Dio http = NetworkUtils.build(middlewares: []).getService();

  Future<Weather> fetchWheater(int locationId, {bool force = false}) {
    return http
        .get('location/$locationId', options: Options(extra: {'refresh': force}))
        .then((Response response) {
      return Weather.fromJson(response.data);
    });
  }
}

ApiService apiService = new ApiService();
