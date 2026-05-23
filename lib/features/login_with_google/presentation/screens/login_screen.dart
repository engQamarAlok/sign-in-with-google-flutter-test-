import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasks_management_app2/features/login_with_google/presentation/widgets/my_submit_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  Future<UserCredential?> signInWithGoogle() async {
    try {
      log("بدء محاولة تسجيل الدخول ...");

      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            '1078903728805-0ncboovq1ichmk8pjv9obl64pp28rd8u.apps.googleusercontent.com',
        scopes: <String>['email'],
        signInOption: SignInOption.standard,
      );
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        log("تم إلغاء العملية من قبل المستخدم");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      log("🎉 تم تسجيل الدخول بنجاح: ${userCredential.user?.displayName}");

      // 👈 السطر السحري لجلب الـ idToken الفعلي من الفايربيس وطباعته
      String? idToken = await userCredential.user?.getIdToken();
      print("###################### FIREBASE ID TOKEN ######################");
      print("$idToken");
      print("###############################################################");

      return userCredential;
    } catch (e) {
      log("❌ خطأ أثناء تسجيل الدخول: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme? themeColors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Image.asset(
                'assets/images/Login_illustration.png',
                height: 500,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: themeColors.tertiary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),

                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: themeColors.primary,
                        ),
                      ),
                      SizedBox(height: 30),
                      MySubmitButton(
                        width: double.infinity,
                        colors: [
                          // برتقالي فاتح (لون المفتاح)
                          // برتقالي متوسط
                          Color(0xFFFB8C00),
                          Color.fromARGB(255, 255, 170, 0),
                          Color.fromARGB(255, 255, 183, 38),
                          Color.fromARGB(255, 255, 190, 92),
                        ],
                        text: "Sign In With Google",
                        widget: SvgPicture.asset(
                          'assets/icons/google_logo.svg',
                          height: 24.0,
                          width: 24.0,
                        ),
                        textColor: const Color.fromARGB(255, 109, 77, 65),

                        onPressed: () async {
                          UserCredential? user = await signInWithGoogle();
                          if (user != null) {
                            // 🎉 تم تسجيل الدخول بنجاح، انقليه لداخل التطبيق الفعلي (Velocity)
                          }
                        },
                        shadowColor: Color.fromARGB(255, 215, 187, 151),
                      ),

                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Scaffold(
                                  appBar: AppBar(title: Text('home page')),
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'مؤقت لانتقل عالهوم بيج',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 /*  MaterialButton(
                        onPressed: () async {
                          UserCredential? user = await signInWithGoogle();
                          if (user != null) {
                            // 🎉 تم تسجيل الدخول بنجاح، انقليه لداخل التطبيق الفعلي (Velocity)
                          }
                        },
                        child: Text('Sign in with google'),
                      ),*/