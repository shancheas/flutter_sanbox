/*
 * Created on Tue Jul 02 2019
 *
 * Made with ❤ by Irfan
 */
import 'package:dio/dio.dart';
import 'package:sanbox/config/config.dart';

import 'network_contract.dart';

class NetworkUtils {
  final Dio http;

  final List<NetworkContract> middlewares;
  List<NetworkContract> tmpMiddlewares = [];

  NetworkUtils._internal({this.http, this.middlewares}) {
    this
        .http
        .interceptors
        ..add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
          this.middlewares.forEach(
              (middleware) => middleware.interceptRequest(request: options));
          this.tmpMiddlewares.forEach(
              (middleware) => middleware.interceptRequest(request: options));

          return options;
        }, onResponse: (Response response) async {
          this.middlewares.forEach(
              (middleware) => middleware.interceptResponse(response: response));
          this.tmpMiddlewares.forEach(
              (middleware) => middleware.interceptResponse(response: response));

          return response;
        }, onError: (DioError e) {
          return e;
        }))
        ..add(CacheInterceptor());
  }

  factory NetworkUtils.build({List<NetworkContract> middlewares}) {
    BaseOptions optoins = BaseOptions(
        baseUrl: Config.baseUrl,
        connectTimeout: Config.timeout * 1000,
        receiveTimeout: Config.timeout * 1000);

    middlewares ??= [];
    middlewares?.removeWhere((middleware) => middleware == null);

    return NetworkUtils._internal(http: Dio(optoins), middlewares: middlewares);
  }

  NetworkUtils setMiddleware(middlewares) {
    if (middlewares is Iterable)
      tmpMiddlewares.addAll(middlewares);
    else
      tmpMiddlewares.add(middlewares);

    return this;
  }

  Dio getService() {
    return this.http;
  }
}

class CacheInterceptor extends Interceptor {
  CacheInterceptor();

  var _cache = new Map<Uri, Response>();

  @override
  onRequest(RequestOptions options) {
    Response response = _cache[options.uri];
    if (options.extra["refresh"] == true) {
      print("${options.uri}: force refresh, ignore cache! \n");
      return options;
    } else if (response != null) {
      print("cache hit: ${options.uri} \n");
      return response;
    }
  }

  @override
  onResponse(Response response) {
    _cache[response.request.uri] = response;
  }

  @override
  onError(DioError e) {
    print('onError: $e');
  }
}
