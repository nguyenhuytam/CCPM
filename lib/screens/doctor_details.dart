import 'package:app_hello/components/button.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_appbar.dart';

class DoctorDetails extends StatefulWidget{
  const DoctorDetails({Key? key, }): super(key: key);


  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails>{
  bool isFav = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(//create a custom app bar widget// tạo tiện ích thanh ứng dụng tùy chỉnh
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          //Favarite Button
          IconButton(
            onPressed: (){
              setState(() {
                isFav = !isFav;
              });
            },
            icon: 
              FaIcon(isFav ?  Icons.favorite_rounded: Icons.favorite_outline,
              color: Colors.red,
          ),
          )
        ],
      ), 
      body: SafeArea(
        child: Column(
          children: <Widget> [
            //build doctor avatar and intro here// xây dựng avatar và giới thiệu bác sĩ tại đây
            AboutDoctor(),
            //details of the doctor// chi tiết của bác sĩ
            DetailBody(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: (){
                  //navigate to booking page//điều hướng đến trang đặt phòng
                  //let's create that//hãy tạo ra cái đó
                  Navigator.of(context).pushNamed('booking_page');
                },
                disable: false,
              )
            )
          ],
        ),
      )
    );
  }
}

class AboutDoctor extends StatelessWidget{
  const AboutDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage('assets/doctor_2.jpg'),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          const Text(
            'Doan van son',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize *0.75,
            child: const Text(
              'MBBS (International Medical Univercity Malaysia), MRCP (Royal College of Physicians, United Kingdom )',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),Config.spaceSmall,
          SizedBox(
            width: Config.widthSize *0.75,
            child: const Text(
              'Sarawak General Hospital',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),Config.spaceSmall,
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget{
  const DetailBody ({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          //doctor exp, patient and rating// bác sĩ kinh nghiệm, bệnh nhân và đánh giá
          const DoctorInfo(),
          Config.spaceMedium,
            const Text(
              'About Dortor',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Config.spaceSmall,
            const Text(
              'afwstgstgrterdFDHFDGHFDSDGATEWRTASETERTER  ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              softWrap: true,
              textAlign: TextAlign.justify,
            )
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget{
  const DoctorInfo ({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      children: const <Widget>[
        //lets extract to another class// cho phép trích xuất sang lớp khác
        InfoCard(
          label: 'Patients',
          value: '109',
        ),
        SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Experiences',
          value: '10 years',
        ),
        SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Rating',
          value: '4.6',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget{
  const InfoCard({ Key? key, required this.label, required this.value}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context){
    return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Config.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 15,
            ),
            child: Column(
              children: <Widget> [
                Text(
                  label ,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}