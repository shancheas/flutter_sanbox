
import 'package:dio/dio.dart';

abstract class NetworkContract {
  Future<void> interceptRequest({RequestOptions request});
  Future<void> interceptResponse({Response response});
}