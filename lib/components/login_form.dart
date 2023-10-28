import 'package:app_hello/components/button.dart';
import 'package:app_hello/main.dart';
import 'package:app_hello/models/auth_model.dart';
import 'package:app_hello/providers/dio_provider.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({Key? key}): super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm>{
  final _formKey = GlobalKey<FormState>();
  final _emailContronller = TextEditingController();
  final _passContronller = TextEditingController();
  bool obscurePass  = true;
  @override
  Widget build(BuildContext context){
    return  Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailContronller,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passContronller,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obscurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  obscurePass  = !obscurePass ;
                }, 
                icon: obscurePass 
                    ?const Icon(
                       Icons.visibility_off_outlined,
                       color: Colors.black38,
                    )
                    :const Icon(
                       Icons.visibility_off_outlined,
                       color: Config.primaryColor,
                    ),
                ),
            ),
          ),
          Config.spaceSmall,
          //login button
          // wrap this button with Consumer
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
              width: double.infinity, 
              title: "Sign In", 
              onPressed: () async{
                //let's try sign in manually // hãy thử đăng nhập thủ công
                // login here
                final token = await DioProvider().getToken(_emailContronller.text, _passContronller.text);
          
                if(token){
                  auth.loginSuccess();// update login status
                  //rediret to main page
                  MyApp.navigatorKey.currentState!.pushNamed('main');
                }
                // Navigator.of(context).pushNamed('main');
              }, 
              disable: false);
            },
          )
        ]
      ),
    );
  }
}

// now let's change something in Laravel
// bây giờ hãy thay đổi một cái gì đó trong Laravel

//Bingo user data has been successfully return//Dữ liệu người dùng Bingo đã được trả về thành công
//now, let complete the login process//bây giờ hãy hoàn tất quá trình đăng nhập
//let's create auth model and use provider to update the state// hãy tạo mô hình xác thực và sử dụng nhà cung cấp để cập nhật trạng thái