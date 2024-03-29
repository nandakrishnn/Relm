import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relm/Login.dart';


class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final TextEditingController signupname = TextEditingController();
  final TextEditingController signuporgName = TextEditingController();
  final TextEditingController signupemail = TextEditingController();
  final TextEditingController signupass = TextEditingController();
  final TextEditingController signucpass = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode namenode=FocusNode();
  final FocusNode orgNamenode=FocusNode();
  final FocusNode orgPass=FocusNode();
  final FocusNode cOrgPass=FocusNode();
   final FocusNode emailnode=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          namenode.unfocus();
          orgNamenode.unfocus();
          orgPass.unfocus();
          cOrgPass.unfocus();
          emailnode.unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Signup baground.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'RELM',
                      style: TextStyle(fontSize: 52, fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'SignUp',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      focusNode:orgNamenode,
                      controller: signuporgName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.person_3_rounded),
                        hintText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the field';
                        } else if (value.length < 1 || value.length > 15) {
                          return 'Please enter a valid username';
                        } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Only alphabets are allowed';
                        } else if (RegExp(r'[!@#%^&*(),.?":{}|<>]')
                            .hasMatch(value)) {
                          return 'Special characters are not allowed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      focusNode: namenode,
                      controller: signupname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the field';
                        } else if (value.length < 1 || value.length > 15) {
                          return 'Please enter a valid username';
                        } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Only alphabets are allowed';
                        } else if (RegExp(r'[!@#%^&*(),.?":{}|<>]')
                            .hasMatch(value)) {
                          return 'Special characters are not allowed';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      focusNode: emailnode,
                      controller: signupemail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the field';
                        } 
                        else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                        
                      }
                        return null;
                      },
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      focusNode: orgPass,
                      controller: signupass,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the field';
                        } else if (value.length < 6) {
                          return 'Password should be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      focusNode: cOrgPass,
                      controller: signucpass,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        hintText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the field';
                        } else if (value != signupass.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: signupemail.text,
                              password: signucpass.text,
                            );
                        
                            if (userCredential.user != null) {
                              
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please wait creating user'),backgroundColor: Colors.green,));
                              await FirebaseFirestore.instance
                                  .collection('UserDetails')
                                  .doc(userCredential.user!.uid)
                                  .set({
                                'username': signupname.text,
                                'email': signupemail.text,
                                'Name': signuporgName.text,
                                'Password': signucpass.text,
                             
                                // 'Image':'vxcvxcvcx'
                              });
                            }
        
                            print('User created');
                            // onSignupClicked();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Login()));
                          } catch (e) {
                            print('Error creating user: $e');
                          }
                        }
                      },
                      child: const Text('SignUp',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(370, 60)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(76, 114, 115, 5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}
