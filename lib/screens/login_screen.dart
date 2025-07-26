import 'package:flutter/material.dart';
import 'package:mad/data/app_shared_pref.dart';
import 'package:mad/screens/home_screen.dart';
import 'package:mad/screens/main_screen.dart';
import 'package:mad/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscureText = true;
  final _key = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailWidget = Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.account_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Username is required";
          }
          return null;
        },
      ),
    );

    final passwordWidget = Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: passwordController,
        obscureText: _isObscureText,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          suffixIcon: _isObscureText
              ? GestureDetector(
                  child: Icon(Icons.visibility),
                  onTap: () {
                    setState(() {
                      _isObscureText = !_isObscureText;
                    });
                  },
                )
              : GestureDetector(
                  child: Icon(Icons.visibility_off),
                  onTap: () {
                    setState(() {
                      _isObscureText = !_isObscureText;
                    });
                  },
                ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Password is required";
          }
          return null;
        },
      ),
    );

    final forgetPassword = Padding(
      padding: EdgeInsets.only(bottom: 16, top: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Text("Forget Password")],
      ),
    );

    final loginButton = SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            String email = emailController.text;
            String password = passwordController.text;
            _login(email, password);
          }
        },
        child: Text("Login", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent),
      ),
    );

    final navigateToRegister = Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?"),
          TextButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              );
              Navigator.push(context, route);
            },
            child: Text("Register"),
          ),
        ],
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/PPUA.png",
                          width: 200,
                          height: 200,
                        ),
                        emailWidget,
                        passwordWidget,
                        forgetPassword,
                        loginButton,
                      ],
                    ),
                  ),
                ),
                navigateToRegister,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(String username, String password) async {
    final appSharedPref = AppSharedPref();
    bool isAuthenticated = await appSharedPref.login(username, password);
    if (isAuthenticated) {
      print("Login success");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login success")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      print("Login failed");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed")));
    }
  }
}
