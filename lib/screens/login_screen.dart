import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isObscureText = true;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final usernameWidget = Padding(padding: EdgeInsets.only(bottom: 8),
    child: TextFormField(
      decoration: InputDecoration(
          hintText: "Username",
          prefixIcon: Icon(Icons.account_circle),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          )
      ),
      validator: (value){
        if(value!.isEmpty){
          return "Username is required";
        }
        return null;
      },
    ),
    );

    final passwordWidget = Padding(padding: EdgeInsets.only(bottom: 8),
    child: TextFormField(
        obscureText: _isObscureText,
        decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            suffixIcon: _isObscureText ? GestureDetector(
              child: Icon(Icons.visibility),
              onTap: (){
                setState(() {
                  _isObscureText = !_isObscureText;
                });
              },
            ) : GestureDetector(
              child: Icon(Icons.visibility_off),
              onTap: (){
                setState(() {
                  _isObscureText = !_isObscureText;
                });
              },
            )
        ),
      validator: (value){
          if(value!.isEmpty){
          return "Password is required";
        }
        return null;
      },
    ),
    );

    final loginButton = SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: (){
          if(_key.currentState!.validate()){
              // Call API or Backend Service for Login
          }
        },
        child: Text("Login", style: TextStyle(color: Colors.white),),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigoAccent
        ),
      ),
    );


    return Scaffold(
        body: Padding(padding: EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/PPUA.png", width: 200, height: 200,),
              Form(
                key: _key,
                  child: Column(
                    children: [
                      usernameWidget,
                      passwordWidget,
                      loginButton
                    ],
                  )
              )
            ],
          ),
        ),
        )
    );
  }
}
