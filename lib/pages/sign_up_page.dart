import 'package:aqua/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aqua/components/signUp_button.dart';
import 'package:aqua/pages/login_page.dart';
import '../components/signup_textfield.dart';
import 'package:get/get.dart';


class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose(){

    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();

  }

  Future signUserUp () async{

          showDialog(
                  context: context,
                  builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.blue,),
                        );
                   }
           );


         try {
           //create user
           await FirebaseAuth.instance.createUserWithEmailAndPassword(
               email: emailController.text.trim(),
               password: passwordController.text.trim());

         }on FirebaseException catch(e){
                 print(e);
         }




  }
  //add user
  Future AddUserDetails(String name,String email,String phone) async{

     await FirebaseFirestore.instance.collection('users').add({
           'Username': name,
           'Email': email,
           'Phone': phone,

     });
     Navigator.pop(context);
     Get.off(() => HomePage(), transition: Transition.leftToRight,duration: Duration(milliseconds: 400));



}
//password confirming and if confirmed,goes inside 'if' block and add the data.
  bool passwordConfirmed(){
    if(passwordController.text.trim() == confirmPasswordController.text.trim()){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
         child: SingleChildScrollView(
           child: Container(
             child: Column(
                   
               children: [

                 const SizedBox(height: 20,),
                 //--------------------------------Signup_text--------------------------------------
                   
                 Text(
                   "SIGN UP",
                   style: TextStyle(
                     color: Colors.grey[600],
                     fontSize: 20,
                     fontFamily:'Kinetika',
                   
                   ),
                 ),
                   const SizedBox(height: 10,),
                 //---------------------------------username---------------------------------------(signup_textfields.dart)
                 CustomTextFieldSignUpUser(
                   
                   controller: usernameController,
                   hintText: "Username",
                   obscureText: false,
                 ),
                   const SizedBox(height: 20,),
                 //--------------------------------email--------------------------------------------(signup_textfields.dart)
                 CustomTextFieldSignUpEmail(
                   
                   controller: emailController,
                   hintText: "Email",
                   obscureText: false,
                 ),
                 const SizedBox(height: 20,),
                 //--------------------------------phone-------------------------------------------(signup_textfields.dart)
                 CustomTextFieldSignupPhone(
                   
                   controller: phoneController,
                   hintText: "Phone",
                   obscureText: false,
                 ),
                  const SizedBox(height: 20,),
                  //------------------------------------------password_field-----------------------(signup_textfields.dart)
                  CustomTextFieldSignupPassword(
                   
                    controller: passwordController,
                    hintText: "Password",

                  ),
                 const SizedBox(height: 20,),
                 CustomTextFieldSignupPassword(
                   
                   controller: confirmPasswordController,
                   hintText: "Confirm Password",

                 ),
                   
                   
                 const SizedBox(height: 20,),
                   
                   
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Text('Already have an account? ',style:TextStyle(fontSize: 16,color: Colors.grey[600],fontFamily: 'Kinetika') ),
                       GestureDetector(
                             onTap: () {
                   
                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
                             },
                           child: Text('Login',style:TextStyle(fontSize: 16,color: Colors.blue[600],fontFamily: 'Kinetika') )),
                     ],
                   ),
                 ),
                 const SizedBox(height: 10,),
                   
                 SignupButton(onPressed: signUserUp), //sign in button(lib/components)
                   
                 const SizedBox(height: 10,),
                   
                   

                   
                   

               ],
                   
             ),
           ),
         ),
      ),


    );
  }
}
