import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welcome/view/custom_button.dart';
import 'package:welcome/view/home_screen.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email_1 = TextEditingController();
  final TextEditingController password_1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/f1.png',
                    width: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      controller: email_1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()),
                      onChanged: (String value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      controller: password_1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter password',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder()),
                      onChanged: (String value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomButton(
                        onTap: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            bool result = await firebaseLogin(
                                email_1.text, password_1.text);

                            if (result) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('email', email_1.text);

                              final String? savedEmail =
                                  prefs.getString('email');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(email: savedEmail),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('LogIn Failed')),
                              );
                            }
                          }
                        },
                        buttonColor: Colors.blueAccent,
                        label: 'Login',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 139, 186, 115)),
                    child: const Text('Forget password ?'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      label: 'signUp',
                      onTap: () {},
                      buttonColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> firebaseLogin(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }
}
