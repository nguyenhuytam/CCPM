// in order to connect to database// để kết nối với cơ sở dữ liệu
// we have to create dio provider first// trước tiên chúng ta phải tạo nhà cung cấp dio
// to post/get data from laravel database// để đăng/lấy dữ liệu từ cơ sở dữ liệu laravel
// and API Token needed for getting data// và API Token cần thiết để lấy dữ liệu
// and thus, JWT used in this video// và do đó, JWT được sử dụng trong video này

// now, let's build dio provider and get token from database// bây giờ, hãy xây dựng nhà cung cấp dio và nhận mã thông báo từ cơ sở dữ liệu

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DioProvider{
  //get token
  Future<dynamic> getToken(String email, String password) async{
    try{
    var response = await Dio().post('http://127.0.0.1:8000/api/login',
      data: {'email':email, 'password': password});

      // if request successfully, then return token// nếu yêu cầu thành công thì trả về token
      if (response.statusCode == 200 && response.data != ''){
        //store returned token into share preferences// lưu trữ mã thông báo được trả về vào tùy chọn chia sẻ
        //for get other data later// để lấy dữ liệu khác sau
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      }else {
        return false;
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
      var user = await Dio().get('http://127.0.0.1:8000/api/user', options: Options(headers: {'Authorization' : 'Bearer $token'}));
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

// as you can see at termial, a generated token is well received// như bạn có thể thấy tại terminal, mã thông báo được tạo sẽ được đón nhận nồng nhiệt
// now, use this token to get user data// bây giờ, hãy sử dụng mã thông báo này để lấy dữ liệu người dùng
// first, let me show the result without token// trước tiên, hãy để tôi hiển thị kết quả mà không cần mã thông báo

// as you can see, the user data has been fetched from database// như bạn có thể thấy, dữ liệu người dùng đã được lấy từ cơ sở dữ liệu
// add inserted into app// thêm vào ứng dụng
// now let's create register page// bây giờ hãy tạo trang đăng ký
