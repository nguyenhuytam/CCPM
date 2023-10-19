import 'package:app_hello/components/appointment_card.dart';
import 'package:app_hello/components/doctor_card.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}): super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  List<Map<String, dynamic>> medCat = [
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"General",
    },
    {
      "icon":FontAwesomeIcons.heartPulse,
      "category":"Cardiology",
    },
    {
      "icon":FontAwesomeIcons.lungs,
      "category":"Respirations",
    },
    {
      "icon":FontAwesomeIcons.hand,
      "category":"Dermatology",
    },
    {
      "icon":FontAwesomeIcons.personPregnant,
      "category":"Gynecology",
    },
    {
      "icon":FontAwesomeIcons.teeth,
      "category":"Dental",
    },
  ];
  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[// add 1 consst
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Amanda', //hard core the user's name at first
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile1.jpg'), // insert image here
                      ),
                    )
                  ],
                ),
                Config.spaceMedium,
                //category listing//danh sach danh muc
                const Text(
                      'category', 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    //build category list//xay dung danh sach danh muc
                    SizedBox(
                      height: Config.heightSize *0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List<Widget>.generate(medCat.length, (index){
                          return Card(
                            margin: const EdgeInsets.only(right: 20),
                            color: Config.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FaIcon(
                                    medCat[index]['icon'],
                                    color:Colors.white,
                                  ),
                                  const SizedBox(width: 20,),
                                  Text(
                                  medCat[index]['category'],
                                  style:const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                ],
                              ), 
                            ), 
                          );
                        }),
                      ),
                    ),
                    Config.spaceSmall,
                    const Text(
                      'Appointment Today', 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    // display appoinment card here // hien thi the hen o day
                    // let's create appoinment card widget // hay tao the tien ich cuoc hen
                    AppointmentCard(),
                    Config.spaceSmall,
                    const Text(
                      'Top Doctors', 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // list of top doctors
                    // let's build doctor card
                    Config.spaceSmall,
                    Column(
                      children: List.generate(10, (index){
                        return  const DoctorCard(
                          route: 'doc_details',
                        );
                      }),
                    )
              ],
            ),
          ),
        ),
      )
    );
  }
}
