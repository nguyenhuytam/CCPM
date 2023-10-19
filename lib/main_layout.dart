import 'package:app_hello/screens/appointment_page.dart';
import 'package:app_hello/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatefulWidget{
  const MainLayout({Key? key}): super(key: key);

  @override
  State<MainLayout> createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout>{
  // variable declaration
  int currentPage =0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        onPageChanged: ((value){
          setState(() {
            // update page index when tab pressed/switch page
            currentPage = value;
          });
        }),
        children: const <Widget>[
          HomePage(),
          AppointmentPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page){
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(microseconds: 500), 
              curve: Curves.easeInOut,
              );
          });
        },
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseChimneyCrack),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
            label: 'Appointments'
          ),
        ],
      ),
    );
  }
}

// let's build home page and appointment page
// as you can see, page view has done
// and there are two main pages show
// let's coplete the home page