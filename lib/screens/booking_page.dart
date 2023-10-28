import 'package:app_hello/components/button.dart';
import 'package:app_hello/components/custom_appbar.dart';
import 'package:app_hello/main.dart';
import 'package:app_hello/models/booking_datetime_converted.dart';
import 'package:app_hello/providers/dio_provider.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  //declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currenIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token; // gettoken for insert booking date and time into database// gettoken để chèn ngày giờ đặt phòng vào cơ sở dữ liệu

  Future<void> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  @override
  void initState(){
    getToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Appointment',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget> [
          SliverToBoxAdapter(
            child: Column(
              children:<Widget> [
                //display table calendar here//hiển thị lịch bảng tại đây
                _tableCalendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25), 
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isWeekend 
            ? SliverToBoxAdapter(
              child:  Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 30),
                  alignment: Alignment.center,
                  child: const Text(
                    'Weekend is not available, please select another date',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            : SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index){
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: (){
                    //when selected, update current index and set time selected to true
                    setState(() {
                      _currenIndex = index;
                      _timeSelected = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currenIndex == index
                        ? Colors.white
                        :Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: _currenIndex == index
                      ? Config.primaryColor
                      :null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currenIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 8,
              ), 
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.5)
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                child: Button(
                  width: double.infinity,
                  title: 'Make Appointment',
                  onPressed: () async{
                    //press button here to store booking details, like date and time//nhấn nút ở đây để lưu trữ chi tiết đặt chỗ, như ngày và giờ
                    //so now, let's build appointment controller first// vậy bây giờ, hãy xây dựng bộ điều khiển cuộc hẹn trước
                    // convert date/day/time into string first// chuyển đổi ngày/ngày/giờ thành chuỗi trước
                    final getDate = DateConverted.getDate(_currentDay);
                    final getDay = DateConverted.getDay(_currentDay.weekday);
                    final getTime = DateConverted.getTime(_currenIndex!);

                    //post using dio
                    //pass all details togetder with doctor id and token// chuyển tất cả các chi tiết cùng với id bác sĩ và mã thông báo
                    final booking = await DioProvider().bookAppointment(
                      getDate, getDay, getTime, doctor['doctor_id'], token!);

                    //if booking return status code 200, then redirect to success booking page// nếu đặt phòng trả về mã trạng thái 200, sau đó chuyển hướng đến trang đặt phòng thành công
                    //now, let's try to make an appointment//bây giờ chúng ta thử hẹn nhau nhé
                    if (booking == 200){
                      MyApp.navigatorKey.currentState!.pushNamed('success_booking');
                    }  
                  },
                  disable: _timeSelected && _dateSelected ? false : true,
                ),
              ),
            )
        ],
      ),
    );
  }
  //table calendar//lịch bàn
  Widget _tableCalendar(){
    return TableCalendar(
      focusedDay: _focusDay, 
      firstDay: DateTime.now(), 
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: 
        BoxDecoration(
          color: Config.primaryColor,
          shape: BoxShape.circle
        ),
      ),
      availableCalendarFormats: const{
        CalendarFormat.month: 'Month',
      },
      onFormatChanged:(format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selecteDay, focuseDay){
        setState(() {
          _currentDay = selecteDay;
          _focusDay = focuseDay;
          _dateSelected = true;

          //check if weekend is selected//kiểm tra xem cuối tuần có được chọn không
          if (selecteDay.weekday == 6 || selecteDay.weekday == 7){
            _isWeekend = true;
            _timeSelected = false;
            _currenIndex = null;
          }else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}

// as you can see, a booking page is built// như bạn thấy, một trang đặt phòng đã được xây dựng
// and booking button will be disable if date or time is not selected// và nút đặt chỗ sẽ bị tắt nếu ngày hoặc giờ không được chọn
// as well as if selecting weekend// cũng như nếu chọn cuối tuần
// and now, lets build success page for booking// và bây giờ, hãy xây dựng trang thành công để đặt phòng
// as some booking details if you want, to demonstrate the appointment page// như một số chi tiết đặt phòng nếu bạn muốn, để minh họa trang cuộc hẹn