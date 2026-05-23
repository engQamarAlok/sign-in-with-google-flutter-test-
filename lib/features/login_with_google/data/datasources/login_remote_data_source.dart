import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginRemoteDataSource {
  /// يقوم بتسجيل الدخول عبر جوجل ويعيد بيانات المستخدم من فايربيز
  Future<UserCredential?> signInWithGoogle();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // نستخدم الـ Constructor Injection لكي نتمكن من عمل Mocking أثناء الاختبار (Testing)
  LoginRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: <String>['email']);

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      log("🌐 [Remote Data Source] بدء محاولة تسجيل الدخول عبر جوجل...");

      // 1. فتح نافذة تسجيل الدخول الخاصة بجوجل
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        log("⚠️ [Remote Data Source] تم إلغاء العملية من قبل المستخدم");
        return null;
      }

      // 2. جلب بيانات التوثيق (Tokens)
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. إنشاء الـ Credential لفايربيز
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. تسجيل الدخول في فايربيز باستخدام الـ Credential
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      log("🎉 [Remote Data Source] تم تسجيل الدخول بنجاح: ${userCredential.user?.displayName}");
      
      // هنا يمكنكِ استخراج الـ idToken لإرساله لاحقاً للباك-إند:
      // String? idToken = googleAuth.idToken;
      
      return userCredential;
    } catch (e) {
      log("❌ [Remote Data Source] خطأ أثناء تسجيل الدخول: $e");
      // في الـ Clean Architecture يفضل رمي Exception مخصص ليتم معالجته في الـ Repository
      throw Exception("Failed to sign in with Google: $e");
    }
  }
}