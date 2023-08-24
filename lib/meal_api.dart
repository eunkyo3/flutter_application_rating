import 'dart:convert';

import 'package:http/http.dart' as http;

class MealApi {
  var url = 'https://itmajor.cafe24.com/kiosk_api/rate.php';
  // 평가 저장
  Future<String> insert(String evalDate, double rating, String comment) async {
    var header = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'mode': 'insert',
      'eval_date': evalDate,
      'rating': rating,
      'comment': comment,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    if (response.statusCode == 200) {
      print('성공');
      var result = jsonDecode(response.body) as Map<String, dynamic>;
      return result['result'];
    } else {
      return 'false';
    }
  }

  // 결과 보기
  Future<dynamic> getList({required eval_date}) async {
    var site = '$url?mode=list&eval_date=$eval_date';
    var response = await http.get(Uri.parse(site));

    if (response.statusCode == 200) {
      print('결과');
      var data = jsonDecode(response.body) as Map<String, dynamic>;

      return data['data']['list'];
    } else {
      return [];
    }
  }

  // 리뷰 보기
  Future<dynamic> getReview({required evalDate}) async {
    var site = '$url?mode=review&eval_date=$evalDate';
    var response = await http.get(Uri.parse(site));

    if (response.statusCode == 200) {
      print('결과');
      var data = jsonDecode(response.body) as Map<String, dynamic>;

      return data['data']['list'];
    } else {
      return [];
    }
  }
}
