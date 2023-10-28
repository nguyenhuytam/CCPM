// import 'package:app_hello/components/login_form.dart';
// import 'package:app_hello/components/sing_up_form.dart';
// import 'package:app_hello/components/social_button.dart';

// import 'package:app_hello/untils/text.dart';
// import 'package:flutter/material.dart';

// import '../untils/config.dart';

// class AuthPage extends StatefulWidget{
//   const AuthPage({Key? key}): super(key: key);

//   @override
//   State<AuthPage> createState() => AuthPageState();
// }

// class AuthPageState extends State<AuthPage>{
//   bool isSingIn = true;
//   @override
//   Widget build(BuildContext context){
//     Config().init(context);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 15,
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 AppText.enText['welcome_text']!,
//                 style: const TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Config.spaceSmall,
//               Text(
//                 isSingIn
//                 ? AppText.enText['signIn_text']!
//                 : AppText.enText['register_text']!,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ), 
//               ),
//               Config.spaceSmall,
//               //login components here
//               isSingIn ? LoginForm() : SingUpForm(),
//               Config.spaceSmall,
//               isSingIn
//               ? Center(
//                 child: TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     AppText.enText['forgot_password']!,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ), 
//                   ),
//                 ),
//               ):Container(),
//               Config.spaceSmall,
//               //add social button sign in
//               const Spacer(),
//               Center(
//                 child: Text(
//                   AppText.enText['social_login']!,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey.shade500,
//                   ),
//                 ),
//               ),
//               Config.spaceSmall,
//               // ignore: prefer_const_constructors
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: const <Widget>[
//                   //let's build social button
//                   ScoialButton(social: 'google'),
//                   ScoialButton(social: 'facebook'),
//                 ],
//               ),
//               Config.spaceSmall,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                   isSingIn
//                   ? AppText.enText['signUp_text']!
//                   : AppText.enText['registered_text']!,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey.shade500,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: (){
//                     setState(() {
//                       isSingIn = !isSingIn;
//                     });
//                   },
//                   child: Text(
//                     isSingIn ? 'Sign Up': 'Sing In',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )

//                 ],
//               ),
//             ],
//           ),
//         ),
//       )
//       );
//   }
// }

// // now, i have done login component
// // up text, lets build main layout and home page
import 'package:flutter/material.dart';
import 'package:app_hello/components/login_form.dart';
import 'package:app_hello/components/sing_up_form.dart';
import 'package:app_hello/components/social_button.dart';
import 'package:app_hello/untils/text.dart';
import 'package:app_hello/untils/config.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 4), // Khoảng trống giữa top của màn hình và văn bản "Welcome"
              Text(
                AppText.enText['welcome_text']!,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4), // Khoảng trống giữa "Welcome" và văn bản "Sign In" hoặc "Register"
              Text(
                isSignIn
                    ? AppText.enText['signIn_text']!
                    : AppText.enText['register_text']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4), // Khoảng trống giữa văn bản "Sign In" hoặc "Register" và biểu mẫu đăng nhập/đăng ký
              isSignIn ? LoginForm() : SingUpForm(),
              SizedBox(height: 4), // Khoảng trống giữa biểu mẫu đăng nhập/đăng ký và văn bản "Forgot Password"
              isSignIn
                  ? Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppText.enText['forgot_password']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Spacer(), // Spacer để căn chỉnh các nút xã hội và nút "Sign Up"/"Sign In" vào giữa
              Text(
                AppText.enText['social_login']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(height: 4), // Khoảng trống giữa văn bản "Social Login" và các nút xã hội
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  ScoialButton(social: 'google'),
                  ScoialButton(social: 'facebook'),
                ],
              ),
              SizedBox(height: 3), // Khoảng trống giữa các nút xã hội và văn bản "Sign Up"/"Sign In"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isSignIn
                        ? AppText.enText['signUp_text']!
                        : AppText.enText['registered_text']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isSignIn = !isSignIn;
                      });
                    },
                    child: Text(
                      isSignIn ? 'Sign Up' : 'Sign In',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
