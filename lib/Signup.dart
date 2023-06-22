import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/LoginPage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confpasswordController = TextEditingController();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _signup() {
    String email = _emailController.text;
    String password = _passwordController.text;
    String firstname = _firstname.text;
    String lastname = _lastname.text;

    _prefs.setString('email', email);
    _prefs.setString('password', password);
    _prefs.setString('firstname', firstname);
    _prefs.setString('lastname', lastname);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Up Successful'),
        content: Text('You can now log in with your new account.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF373857),
              Color(0xFF373857),
              Color(0xFF373857),
            ],
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 7),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white38,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Welcome back',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF373857),
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Sign up with your account',
                                style: TextStyle(
                                  color: Color(0xFF373857),
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(height: 30),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _firstname,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "First Name cannot be empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "First Name",
                                        hintText: "Enter your First Name",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _lastname,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Last Name cannot be empty";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Last Name",
                                        hintText: "Enter your Last Name",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _emailController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Email cannot be empty";
                                        } else if (!val.contains('@')) {
                                          return "Please enter a valid email";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Email",
                                        hintText: "Enter your Email",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _passwordController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Password cannot be empty";
                                        } else if (val.length < 8) {
                                          return "Password must be at least 8 characters long";
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        hintText: "Enter your Password",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _confpasswordController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Please confirm your password";
                                        } else
                                        if (val != _passwordController.text) {
                                          return "Passwords do not match";
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: "Confirm Password",
                                        hintText: "Confirm your Password",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        _signup();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF1967AF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      "Signup",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    height: 1,
                                    width: 120,
                                    color: Color(0xFF373857),
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
                                    height: 1,
                                    width: 120,
                                    color: Color(0xFF373857),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),
                              Container(
                                width: 280, color:
                              Color(0xFFE0F1FF), height: 150,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 280, color:
                                        Color(0xFFE0F1FF), height: 170,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Container(height: 100, width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(0),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/faceid.jpg'),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 0,),
                                              Text("Login with Face ID",
                                                style: TextStyle(
                                                    color: Color(0xFF373857),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),),

                                              SizedBox(height: 10),
                                              Text(
                                                "Your face is now your password use your FACE ID and get start",
                                                style: TextStyle(
                                                    color: Color(0xFF373857),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8),),
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
    );
  }
  }
