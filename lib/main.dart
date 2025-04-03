import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  final authController = Get.put(AuthController()); 
  
  runApp(MyApp(initialRoute: authController.auth.currentUser != null ? '/tasks' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute; 

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute, 
      getPages: Routes.routes,
    );
  }
}
