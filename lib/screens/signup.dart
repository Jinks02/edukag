import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/sign_up_view_model.dart';
import 'get_started_view.dart';
import 'home_view.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  // String _email = "";
  // String _password = "";
  // String _name = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = const TextStyle(color: Colors.grey, fontSize: 14);
    TextStyle linkStyle = const TextStyle(color: Colors.green);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30.0),
                SizedBox(
                  height: 300,
                  child: Image.asset(
                    "assets/images/signup_image.png",
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Signup",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Enter your details for new account",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const Text(
                //   "Name",
                //   style: TextStyle(
                //     fontSize: 16.0,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.grey,
                //   ),
                // ),
                // TextFormField(
                //   controller: _usernameController,
                //   keyboardType: TextInputType.name,
                //   decoration:
                //       const InputDecoration(hintText: "Enter your name"),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please enter your name";
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     if (value!.isNotEmpty) {
                //       _usernameController.text = value;
                //     }
                //   },
                // ),
                const SizedBox(height: 20.0),
                const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(hintText: "Enter your email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      _emailController.text = value;
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    //labelText: "Password",
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value!.isNotEmpty) {
                      _passwordController.text = value;
                    }
                  },
                ),
                const SizedBox(height: 15.0),
                Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        style: defaultStyle,
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'By continuing you agree to our'),
                          TextSpan(
                              text: 'Terms of Service \n',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service');
                                }),
                          const TextSpan(text: 'and '),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: linkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Privacy Policy"');
                                }),
                        ],
                      ),
                    )),
                const SizedBox(height: 15.0),
                Consumer<SignUpViewModel>(builder: (context, value, child) {
                  return Center(
                    child: Container(
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(_usernameController.text);
                            //TODO: perform login with _email and _password
                            UserCredential? userCredential =
                                await value.signUpWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                    _usernameController.text);

                            if (userCredential != null) {
                              // todo: find an alternative to scaffold messenger
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.orange,
                                      content: Text("Sign up success")));
                              Navigator.push(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.orange,
                                      content: Text("Sign up failed")));
                              Navigator.push(
                                (context),
                                MaterialPageRoute(
                                  builder: (context) => GetStarted(),
                                ),
                              );
                            }
                          }
                        },
                        child: value.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Register Now",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => LoginPage()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
