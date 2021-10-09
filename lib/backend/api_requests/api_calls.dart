import 'api_manager.dart';

Future<dynamic> messageCall({
  String number = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'message',
    apiUrl: 'http://floodanalyser.com/twilio.php',
    callType: ApiCallType.GET,
    headers: {},
    params: {
      'number': number,
    },
    returnResponse: true,
  );
}

Future<dynamic> callCall({
  String number = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'call',
    apiUrl: 'http://floodanalyser.com/twilio_call.php',
    callType: ApiCallType.GET,
    headers: {},
    params: {
      'number': number,
    },
    returnResponse: true,
  );
}
