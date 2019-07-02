import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:sanbox/utils/network/network_contract.dart';

class DefaultParamsMiddleware extends NetworkContract {
  final defaultParams = {
    'filter_role': '[]',
    'filter_category': '[]',
    'filter_branch': '[]',
    'filter_type': '[]'
  };

  @override
  Future<void> interceptRequest({RequestOptions request}) async {
    request.queryParameters = {
      ...defaultParams,
      ...request.queryParameters
    };
  }

  @override
  Future<void> interceptResponse({Response response}) {
    return null;
  }
  
}