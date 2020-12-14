// import 'package:http/http.dart' as http;

// class SpentAllApi {
//   static const url = 'http://localhost:5000';

//   final String token;

//   SpentAllApi({this.token});

//   Future<void> get(
//       {String endPoint,
//       Map<String, String> headers = {
//         'x-access-token': 'Bearer $token',
//       },
//       dynamic body}) {
//     return http.get('$url$endPoint', headers: headers);
//   }

//   Future<void> post(
//       {String endPoint,
//       Map<String, String> headers = {
//         'Content-Type': 'application/json',
//         'x-access-token': 'Bearer $token',
//       },
//       dynamic body}) {
//     return http.post('$url$endPoint', headers: headers, body: body);
//   }
// }
