import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'dashboard.dart'; // Make sure this exists
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

   TextEditingController emailText = TextEditingController();
   TextEditingController pasText = TextEditingController();

   Future<void> signup() async {
     try {
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailText.text.trim(),
         password: pasText.text.trim(),
       ).then((val){
         print("registrer");
       }).onError((error, stackTrace) {
         print(error);
         print("================================================================");
       },);

       Get.offAll(Dashboard(userid: FirebaseAuth.instance.currentUser!.uid));
// Navigate to Wrapper screen after signup
     } catch (e) {
       Get.snackbar("Signup Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
     }
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              TextField(
                controller: emailText,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.email_outlined),
                    onPressed: () {},
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black45),
                  ),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: pasText,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility_off_outlined),
                    onPressed: () {},
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.deepOrange),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black45),
                  ),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  String uEmail = emailText.text.trim();
                  String uPass = pasText.text.trim();
                  signup();

                  print("Email: $uEmail, Password: $uPass");
                  FirebaseAuth.instance.signInWithEmailAndPassword(email: emailText.text, password: pasText.text).then((value) {
                    if(value.credential!=null){
                      print("=====================================");
                      print(value.credential!.accessToken);
                      FirebaseAuth.instance.signInWithCredential(value.credential!).then((userCred) {
                        print(userCred.additionalUserInfo!.username);
                      },);
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(userid: "faltana",)));
                  },);


                  // You can navigate or authenticate here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text(
                  "signup",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
