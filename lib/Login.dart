import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relm/admin/homeAdmin.dart';
import 'package:relm/signUp.dart';
import 'package:relm/user%20home%20screens/home.dart';


class Login extends StatelessWidget {
   Login({super.key});


    final String adminuser='nanda.krishnn';
    final String adminpass='krishnn';
    final TextEditingController adminnamecontroller=TextEditingController();
    final TextEditingController adminpasscontroller=TextEditingController();


   final GlobalKey<FormState>formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Login Baground.jpeg'), // Replace with the correct image path
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
                const Text('RELM', style: TextStyle(fontSize: 52, fontWeight: FontWeight.w700)),
                const Text('TO OTHER WORLD', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                const SizedBox(height: 55,),
                TextFormField(
                  controller: adminnamecontroller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email', 
                    iconColor: Colors.white,
                    prefixIcon: const Icon(Icons.email_outlined,),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
                  ),
                  validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Please fill the feild';
                    }
                    else if
                      (value.length<3||value.length>25){
                        return 'Please enter the correct username';
                      }
                    //  else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    //   return 'Only alphabets are allowed';
                    // }
                    //   else if (RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
                    //   return 'Special characters are not allowed';
                    // } 
                      else{
                        return null;
                      }
                    
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(

                    controller: adminpasscontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
                    enabled: true,
                    enabledBorder: OutlineInputBorder()
                  ),
                         validator: (value) {
                    if(value==null||value.isEmpty){
                      return 'Please fill the feild';
                    }
                    else if
                      (value.length<3||value.length>15){
                        return 'Please enter the correct password';
                      }
                    // else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    //   return 'Only alphabets are allowed';
                    // }
                      else{
                        return null;
                      }
                    
                  },
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                          if(formKey.currentState!.validate()){
                      if(adminnamecontroller.text==adminuser&&adminpasscontroller.text==adminpass){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminHome()));
                      }
                      else{
                        FirebaseAuth.instance.signInWithEmailAndPassword(email:adminnamecontroller.text, password:adminpasscontroller.text).then((value){
                         
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));

                        }).onError((error, stackTrace) { print('Error ${error.toString()}');});
                      }
          
                    }
                  },
                  child: const Text('Login', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(370, 60)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(76, 114, 115, 5)),
                  ),
                ),
                const SizedBox(height: 22,),
                GestureDetector(
                  onTap: () {
                 
                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
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
    );
  }
}