import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/homeAdmin.dart';
import 'package:relm/signUp.dart';
import 'package:relm/user%20home%20screens/frogot_password.dart';
import 'package:relm/user%20home%20screens/home.dart';
import 'package:relm/user%20home%20screens/splash/splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);


  final String adminuser = 'nanda.krishnn';
  final String adminpass = 'krishnn';
  final TextEditingController adminnamecontroller = TextEditingController();
  final TextEditingController adminpasscontroller = TextEditingController();
  final FocusNode emailnode=FocusNode();
   final FocusNode passnode=FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          emailnode.unfocus();
          passnode.unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/Login Baground.jpeg'), // Replace with the correct image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('RELM',
                      style:
                          TextStyle(fontSize: 52, fontWeight: FontWeight.bold)),
                  const Text('TO OTHER WORLD',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 55,
                  ),
                  TextFormField(
                    focusNode: emailnode,
                    controller: adminnamecontroller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      iconColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill the feild';
                      } else if (value.length < 3 || value.length > 100) {
                        return 'Please enter the correct username';
                      } 
                  
                      //  else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      //   return 'Only alphabets are allowed';
                      // }
                      //   else if (RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
                      //   return 'Special characters are not allowed';
                      // }
                      else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: passnode,
                    controller: adminpasscontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.password),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9)),
                        enabled: true,
                        enabledBorder: const OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill the feild';
                      } else if (value.length < 3 || value.length > 15) {
                        return 'Please enter the correct password';
                      }
                      // else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      //   return 'Only alphabets are allowed';
                      // }
                      else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPass()));
                    },
                    child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (adminnamecontroller.text == adminuser &&
                            adminpasscontroller.text == adminpass) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminHome()));
                        } else {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: adminnamecontroller.text,
                                  password: adminpasscontroller.text)
                              .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signing you In'),backgroundColor: Colors.green,));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                                    changingSharedValue();
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Invalid User'),
                              backgroundColor: Colors.red,
                            ));
                            print('Error ${error.toString()}');
                          });
                        }
                        
                      }
                      
                    },
                    child: const Text('Login',
                        style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(370, 60)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(76, 114, 115, 5)),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: const Text(
                      'Dont have an account? Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decorationThickness: 2.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> changingSharedValue() async {
    final shared = await SharedPreferences.getInstance();
    await shared.setBool(saveKey, true);
}
}
