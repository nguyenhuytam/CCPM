import 'package:intl/intl.dart';

// this basically is to convert date/day/time from calendar to string// về cơ bản việc này là chuyển đổi ngày/ngày/giờ từ lịch sang chuỗi
class DateConverted{
  static String getDate(DateTime date){
    return DateFormat.yMd().format(date);
  }

  static String getDay(int day){
    switch(day){
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Sunday';           
    }
  }

  static String getTime(int time){
    switch(time){
      case 1:
        return '9:00 AM';
      case 2:
        return '10:00 AM';
      case 3:
        return '11:00 AM';
      case 4:
        return '12:00 AM';
      case 5:
        return '13:00 PM';
      case 6:
        return '14:00 PM';
      case 7:
        return '15:00 PM';
      default:
        return '9:00 AM';
    }
  }
}