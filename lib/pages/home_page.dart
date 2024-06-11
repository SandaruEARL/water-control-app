import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  void SignUserOut(){

    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
       appBar: AppBar(actions: [IconButton(onPressed: SignUserOut, icon: Icon(Icons.logout),color: Colors.white,)],backgroundColor: Colors.blue[600],centerTitle: false,title: Text("Home",style:TextStyle(fontFamily: "roboto",color: Colors.white),)),
       body: Text("looged in as:" + user.email!),
       backgroundColor: Colors.grey[200],


    );
  }
}
