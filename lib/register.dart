import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> doRegister(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,//"barry.allen@example.com",
          password: password//"SuperSecretPassword!"
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Successfully"),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The password provided is too weak."),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The account already exists for that email."),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Center(
                child: Container(
                  width: 350,
                  //color: Colors.greenAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(hintText: "name"),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: TextFormField(
                            controller: loginController,
                            decoration: const InputDecoration(hintText: "login"),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your login';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(hintText: "password"),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          child: TextFormField(
                            obscureText: true,
                            controller: repeatPasswordController,
                            decoration: const InputDecoration(hintText: "repeat password"),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Repeat your password';
                              }
                              if (passwordController.text != repeatPasswordController.text){
                                return 'This password does not match the past';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              onPressed: () =>
                              {if (_formKey.currentState!.validate()) {
                                doRegister(loginController.text, passwordController.text)
                              }},
                              child: const Text("register"))),
                    ],
                  ),
                ))));
  }
}