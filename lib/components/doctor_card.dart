import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';

// change this to stateless
class DoctorCard extends StatelessWidget{
  const DoctorCard({Key? key, required this.route}): super(key: key);
  
  final String route;
  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
        elevation: 5,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: Config.widthSize *0.33,
              child: Image.asset('assets/doctor_2.jpg', fit: BoxFit.fill,),
            ),
            Flexible(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  const Text(
                    'Nguyen quoc huy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Denal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget> [
                        Icon(Icons.star_border, color: Colors.yellow, size: 16,),
                        Spacer(flex: 1,),
                        Text('4,5'),
                        Spacer(flex: 1,),
                        Text('Reviews'),
                        Spacer(flex: 1,),
                        Text('(20)'),
                        Spacer(flex: 7,),
                      ],
                    )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        // redirect to doctor datails page//chuyển hướng đến trang dữ liệu bác sĩ
        //redirect to doctor details//chuyển hướng đến chi tiết bác sĩ
        Navigator.of(context).pushNamed(route);
      }, 
      )
      
    );
  }
}