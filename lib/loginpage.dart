import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blooddonation/home/home_page.dart';
import 'package:flutter_blooddonation/home/otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String verify = "";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController countrycode = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 110),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 115),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("DONATE",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.w600,color: Colors. black
                  ),),
                ],
              ),
            ), Text("YOUR BLOOD ",style: TextStyle(
              fontSize: 29,fontWeight: FontWeight.w600,color: Colors.red
            ),),

            Container(
              height: 300,
              child: Center(
                child: Image.asset("assets/pics/bld.jpg"),
              ),
            ),
            SizedBox(height: 20), // Add some spacing between the image and the button
      Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey.shade700),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,),

              SizedBox(
                width: 40,
                child: TextField(
                  controller: countrycode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
             SizedBox(width: 10,),
             Text("|",style: TextStyle(
               fontSize: 40,color: Colors.grey.shade500
             ),
             ),
             SizedBox(width: 10,),
             Expanded(
                 child: TextField(
                   onChanged: (value){
                     phone = value;
                   },
                   keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                     border: InputBorder.none,hintText: "Phone"
                   ),
                 ))
            ],
          ),
        ),
      ),
            GestureDetector(
              onTap: ()async{
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '${countrycode.text+phone}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    LoginPage.verify = verificationId;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Otp(),));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );


              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                width: 190,
                child: Center(
                  child: Text('Sent the code',style: TextStyle(
                      fontWeight: FontWeight.w600,fontSize:20,color: Colors.white
                  ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
