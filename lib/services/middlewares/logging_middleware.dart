import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:sanbox/utils/network/network_contract.dart';

class Logging extends NetworkContract {
  @override
  Future<void> interceptRequest({RequestOptions request}) async {
    print('${request.baseUrl}${request.path}');
  }

  @override
  Future<void> interceptResponse({Response response}) {
    return null;
  }
  
}