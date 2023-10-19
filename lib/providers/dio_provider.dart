// in order to connect to database// để kết nối với cơ sở dữ liệu
// we have to create dio provider first// trước tiên chúng ta phải tạo nhà cung cấp dio
// to post/get data from laravel database// để đăng/lấy dữ liệu từ cơ sở dữ liệu laravel
// and API Token needed for getting data// và API Token cần thiết để lấy dữ liệu
// and thus, JWT used in this video// và do đó, JWT được sử dụng trong video này

// now, let's build dio provider and get token from database// bây giờ, hãy xây dựng nhà cung cấp dio và nhận mã thông báo từ cơ sở dữ liệu

import 'dart:convert';

import 'package:dio/dio.dart';


class DioProvider{
  //get token
  Future<dynamic> getToken(String email, String password) async{
    try{
    var response = await Dio().post('http://127.0.0.1:8000/api/login',
      data: {'email':email, 'password': password});

      // if request successfully, then return token// nếu yêu cầu thành công thì trả về token
      if (response.statusCode == 200 && response.data != ''){
        return response.data;
      }
    }catch(error){
      return error;
    }
  }
  
  // the url "http://127.0.0.1:8000" is local database// url "http://127.0.0.1:8000" là cơ sở dữ liệu cục bộ
  // and "api/login" is the end point that will be set later in Laravel// và "api/login" là điểm cuối sẽ được đặt sau trong Laravel

  // get user data// lấy dữ liệu người dùng
  Future<dynamic> getUser(String token) async {
    try{
      var user = await Dio().get('http://127.0.0.1:8000/api/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    // if request successfully, then erturn user data // nếu yêu cầu thành công thì trả lại dữ liệu người dùng   
    if (user.statusCode == 200 && user.data != ''){
        return json.encode(user.data);
      }
    }catch(error){
      return error;
    }
  }
}

// class DioProvider {
//   final Dio _dio = Dio();

//   Future<String?> getToken(String email, String password) async {
//     try {
//       final response = await _dio.post('http://127.0.0.1:8000/api/login',
//           data: {'email': email, 'password': password});

//       if (response.statusCode == 200) {
//         if (response.data != null) {
//           return response.data.toString();
//         } else {
//           throw Exception('Không có dữ liệu trả về từ máy chủ.');
//         }
//       } else {
//         throw Exception('Yêu cầu không thành công. Mã lỗi: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<String?> getUser(String token) async {
//     try {
//       final response = await _dio.get('http://127.0.0.1:8000/api/user',
//           options: Options(headers: {'Authorization': 'Bearer $token'}));

//       if (response.statusCode == 200) {
//         if (response.data != null) {
//           return json.encode(response.data);
//         } else {
//           throw Exception('Không có dữ liệu trả về từ máy chủ.');
//         }
//       } else {
//         throw Exception('Yêu cầu không thành công. Mã lỗi: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw error;
//     }
//   }
// }
