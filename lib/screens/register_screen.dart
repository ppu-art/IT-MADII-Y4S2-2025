import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad/data/app_shared_pref.dart';
import 'package:mad/screens/home_screen.dart';
import 'package:mad/screens/login_screen.dart';
import 'package:mad/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscureText = true;
  final _key = GlobalKey<FormState>();

  final _fullNameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fullNameWidget = Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: _fullNameTextEditingController,
        decoration: InputDecoration(
          hintText: "Full Name",
          prefixIcon: Icon(Icons.account_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "FullName is required";
          }
          return null;
        },
      ),
    );

    final emailWidget = Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: _emailTextEditingController,
        decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.account_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Email is required";
          }
          return null;
        },
      ),
    );

    final passwordWidget = Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: _passwordTextEditingController,
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

    final registerButton = Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (_key.currentState!.validate()) {
              String fullName = _fullNameTextEditingController.text;
              String email = _emailTextEditingController.text;
              String password = _passwordTextEditingController.text;
              _register(fullName, email, password);
            }
          },
          child: Text("Register", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent),
        ),
      ),
    );

    final _skip = Padding(
      padding: EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => MainScreen(),
              );
              Navigator.pushReplacement(context, route);
            },
            child: Text("Skip"),
          ),
        ],
      ),
    );

    final navigateToLogin = Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?"),
          TextButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (context) => LoginScreen(),
              );
              Navigator.pushReplacement(context, route);
            },
            child: Text("Login"),
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
                        fullNameWidget,
                        emailWidget,
                        passwordWidget,
                        registerButton,
                        _skip,
                      ],
                    ),
                  ),
                ),
                navigateToLogin,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register(String fullName, String email, String password) async {
    // final appSharedPref = AppSharedPref();
    // await appSharedPref.register(fullName, email, password);

    final auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print("Error Code : ${e.code}");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Register failed, ${e.code}")));
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Register failed, ${error}")));
    }
  }
}
