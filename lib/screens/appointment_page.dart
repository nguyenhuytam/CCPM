import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget{
  const AppointmentPage({Key? key}): super(key: key);

  @override
  State<AppointmentPage> createState() => AppointmentPageState();
}
// enum for appointment status
// enum cho chỉ số cuộc hẹn
enum FilterStatus{ upcoming, complete, cancel}

class AppointmentPageState extends State<AppointmentPage>{
  FilterStatus status = FilterStatus.upcoming; //initial status//trạng thái ban đầu
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [
    {
      "doctor_name":"doan son",
      "doctor_profile":"assets/doctor_2.jpg",
      "category":"Dental",
      "status":FilterStatus.upcoming,
    },
    {
      "doctor_name":"van son",
      "doctor_profile":"assets/doctor_3.jpg",
      "category":"Cardiology",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"son doan",
      "doctor_profile":"assets/doctor_4.jpg",
      "category":"Respiration",
      "status":FilterStatus.complete,
    },
    {
      "doctor_name":"doan van son",
      "doctor_profile":"assets/doctor_5.jpg",
      "category":"General",
      "status":FilterStatus.cancel,
    },
  ];
  @override
  Widget build(BuildContext context){
    // return filtered appointment//quay lại cuộc hẹn đã lọc
    // let's create schedule info // hãy tạo thông tin lịch trình
    List<dynamic> filteredSchedules = schedules.where((var schedule){
      // switch (schedule['status']){
      //   case 'upcoming':
      //     schedule['status'] = FilterStatus.upcoming;
      //     break;
      //   case 'complete':
      //     schedule['status'] = FilterStatus.complete;
      //     break;  
      //   case 'cancel':
      //     schedule['status'] = FilterStatus.cancel;
      //     break;   
      // }
      return schedule['status'] == status;
    }).toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top:20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            const Text(
              'Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      // this is filter tabs// đây là tab lọc
                      for (FilterStatus filterStatus in FilterStatus.values)
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              if (filterStatus == FilterStatus.upcoming){
                                status = FilterStatus.upcoming;
                                _alignment = Alignment.centerLeft;
                              }else if (filterStatus == 
                                FilterStatus.complete){
                                status = FilterStatus.complete;
                                _alignment = Alignment.center;
                              }else if (filterStatus == 
                                FilterStatus.cancel){
                                status = FilterStatus.cancel;
                                _alignment = Alignment.centerRight;  
                              }
                            });
                          },
                          child: Center(
                            child: Text(filterStatus.name),
                          ),
                        )
                      )
                    ]
                  )
                ),
                AnimatedAlign(
                  alignment: _alignment, 
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                itemBuilder: ((context, index ){
                  var _schedule = filteredSchedules[index];
                  bool isLastElement = filteredSchedules.length + 1 == index;
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: !isLastElement
                      ? const EdgeInsets.only(bottom: 20)
                      : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                AssetImage(_schedule['doctor_profile']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['doctor_name'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    _schedule['category'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // Schedule Card// Thẻ lịch trình
                          const ScheduleCard(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: (){},
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Config.primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor,
                                  ),
                                  onPressed: (){},
                                  child: const Text(
                                    'Reschedule',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),  
                    
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

    // in this appointment page
    // there are 3 status, upcoming, complete and cancel
    // so need to create 3 status tabs for filtering appointment status
    
    // trong trang cuộc hẹn này
    // có 3 trạng thái, sắp tới, hoàn thành và hủy
    // nên cần tạo 3 tab trạng thái để lọc trạng thái cuộc hẹn

    // Schedule Widget// len lich cho tien ich
class ScheduleCard extends StatelessWidget{
  const ScheduleCard({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.calendar_today,
          color: Config.primaryColor,
          size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Monday, 11/28/2022',
            style: TextStyle(color: Config.primaryColor),
          ),
          SizedBox(width: 20,),
          Icon(Icons.access_alarm,
          color: Config.primaryColor,
          size: 17
          ),
          SizedBox(width: 5,),
          Flexible(
            child: Text(
              '2:00 PM', 
              style: TextStyle(color: Config.primaryColor),
              ))
        ],
      ),
    );
  }
}

// now, the appointment page UI has been done
// it can filter appointment status that fetched from database
// at this moment, all data/info is hard code for UI design
// as far, both home page and appointment page have been done
// up next, let's build doctor details UI, and also Booking function