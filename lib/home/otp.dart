import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blooddonation/home/home_page.dart';
import 'package:flutter_blooddonation/loginpage.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
   var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top:0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: Center(
                child: Image.asset("assets/pics/bld.jpg"),
              ),
            ),
            SizedBox(height: 20),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value){
                code = value;
              },

            ),// Add some spacing between the image and the button
            Padding(
              padding: const EdgeInsets.all(13.0),
              // child: Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 1,color: Colors.grey.shade700),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: 10,),
              //
              //       SizedBox(
              //         width: 40,
              //         child: TextField(
              //           decoration: InputDecoration(
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 10,),
              //       Text("|",style: TextStyle(
              //           fontSize: 40,color: Colors.grey.shade500
              //       ),
              //       ),
              //       SizedBox(width: 10,),
              //       Expanded(
              //           child: TextField(
              //             keyboardType: TextInputType.number,
              //             decoration: InputDecoration(
              //                 border: InputBorder.none,hintText: "Phone"
              //             ),
              //           ))
              //     ],
              //   ),
              // ),
            ),
            GestureDetector(
              onTap: ()async{
                try{
                PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(
                        verificationId: LoginPage.verify, smsCode: code);

                // Sign the user in (or link) with the credential
                await auth.signInWithCredential(credential);
                }
              catch(e){
                  print("wrong otp");
              }
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                width: 220,
                child: Center(
                  child: Text('Login',style: TextStyle(
                      fontWeight: FontWeight.w600,fontSize:20,color: Colors.white
                  ),
                  ),
                ),
              ),
            ),



                TextButton(
                    onPressed: (){
                      Navigator.popAndPushNamed(context, "phone",);
                    },
                    child: Text("Edit phone number?",
                      style: TextStyle(
                  fontSize: 16,color: Colors.black

                ),
                    )
                ),
          ],
        ),
      ),
    );
  }
}
