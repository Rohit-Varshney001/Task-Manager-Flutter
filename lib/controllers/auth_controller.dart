import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
  super.onInit();
  user.bindStream(auth.authStateChanges());

  Future.delayed(Duration(milliseconds: 500), () { // ✅ Small delay
    ever(user, _setInitialScreen);
  });
}

 void _setInitialScreen(User? user) {
    if (!Get.isRegistered<GetMaterialApp>()) {
      Future.delayed(Duration(milliseconds: 500), () {
        _setInitialScreen(user);
      });
      return;
    }

    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/tasks');
    } 
  }
  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Account created!");
      Get.offAllNamed('/tasks'); // Navigate to Task Screen after signup
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Logged in successfully!");
      Get.offAllNamed('/tasks'); // Navigate to Task Screen
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.offAllNamed('/login'); // Redirect to login screen after logout
  }
}
