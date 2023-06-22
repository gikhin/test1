

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/Home.dart';
import 'package:test1/Signup.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;


    String? storedEmail = _prefs.getString('email');
    String? storedPassword = _prefs.getString('password');

    if (email == storedEmail && password == storedPassword) {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: formKey,
        child: Container(

          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xFF373857),
                    Color(0xFF373857),
                    Color(0xFF373857),
                  ]
              )
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 7),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    TextButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }, child:
                    Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 23),),),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.white,
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    }, child:
                    Text("REGISTER",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white38,fontSize: 23),),),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('Welcome back',style: TextStyle(fontWeight: FontWeight.bold,color:  Color(0xFF373857),fontSize: 30),),
                            SizedBox(height: 10,),
                            Text('Sign in with your account',style: TextStyle(color:  Color(0xFF373857),fontSize: 17),),
                            SizedBox(height: 30,),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, right: 15.0,
                                    left: 15.0, top: 12.0,
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                    validator: (val) {
                                      if (val==null||val.isEmpty) {
                                        return "Please Enter Your Email";
                                      } else if (!val.contains('@')) {
                                        return "Please enter a valid email";
                                      }
                                      return null;
                                    },

                                    decoration: InputDecoration(labelText: "Email-Id",
                                      hintText: "Enter Your Email",
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, right: 15.0,
                                    left: 15.0, top: 12.0,
                                  ),
                                  child: TextFormField(
                                    controller:_passwordController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Password Cannot be Empty";
                                      } else if (val.length < 8) {
                                        return "Password must be 8 letters long";
                                      }
                                      return null;
                                    },

                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: "Enter Your Password",
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(height: 20),

                            Container(
                              height: 55,
                              margin: EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xFF1967AF),
                              ),
                              child: SizedBox(
                                width: double.infinity, // Set the width to occupy the entire container
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      debugPrint("All Validation Passed");
                                    }
                                    _login();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF1967AF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 30),

                            Padding(
                              padding: const EdgeInsets.only(left: 45),
                              child: Row(
                                children: [
                                  Text("Forgot your password?",style: TextStyle(color: Color(0xFF373857),fontSize: 13,fontWeight: FontWeight.w500),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Reset here",style: TextStyle(color: Color(0xFF373857),fontWeight: FontWeight.bold,fontSize: 14),),
                                  ),
                                ],
                              ),
                            ),SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 1,width: 120,color: Color(0xFF373857),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1967AF),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "OR",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,width: 120,color: Color(0xFF373857),
                                ),
                              ],
                            ),

                            SizedBox(height: 20),
                            Container(
                              width: 280,color:
                            Color(0xFFE0F1FF),height: 150,
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 280,color:
                                    Color(0xFFE0F1FF),height: 170,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(height: 100,width: 100,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),
                                              image: DecorationImage(
                                                image: AssetImage('assets/faceid.jpg'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 0,),
                                          Text("Login with Face ID",style: TextStyle(color: Color(0xFF373857),
                                              fontWeight: FontWeight.bold,fontSize: 14),),

                                          SizedBox(height: 10),
                                          Text("Your face is now your password use your FACE ID and get start",style: TextStyle(color: Color(0xFF373857),
                                              fontWeight: FontWeight.bold,fontSize: 8),),
                                        ],
                                      ),),
                                  )


                                ]),
                    ),
                  ]),
                ),

              )),
          ),
        ]),
      ),
    ));
  }
}