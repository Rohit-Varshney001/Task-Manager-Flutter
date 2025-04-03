import 'package:get/get.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/task_screen.dart';

class Routes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/register', page: () => RegisterScreen()),
    GetPage(name: '/tasks', page: () => TaskScreen()),
  ];
}
