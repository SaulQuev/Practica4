import 'package:flutter/widgets.dart';
import 'package:pmsn2023/screens/add_career_screen.dart';
import 'package:pmsn2023/screens/add_task_screen.dart';
import 'package:pmsn2023/screens/add_teacher_screen.dart';
import 'package:pmsn2023/screens/calendar_screen.dart';
import 'package:pmsn2023/screens/career_screen.dart';
import 'package:pmsn2023/screens/dashboard_screen.dart';
//mport 'package:pmsn2023/screens/detail_movie_screen.dart';
import 'package:pmsn2023/screens/item_screen.dart';
import 'package:pmsn2023/screens/login_screen.dart';
import 'package:pmsn2023/screens/popular_screen.dart';
import 'package:pmsn2023/screens/provider_screen.dart';
import 'package:pmsn2023/screens/register_screen.dart';
import 'package:pmsn2023/screens/task_screen.dart';
import 'package:pmsn2023/screens/teacher_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/login': (BuildContext context) => const LoginScreen(),
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/item': (BuildContext context) => ItemScreen(),
    '/tasks': (BuildContext context) => const TaskScreen(),
    '/addTask': (BuildContext context) => AddTaskScreen(),
    '/careers': (BuildContext context) => const CareerScreen(),
    '/addCareer': (BuildContext context) => AddCareerScreen(),
    '/teachers': (BuildContext context) => const TeacherScreen(),
    '/addTeacher': (BuildContext context) => AddTeacherScreen(),
    '/popular': (BuildContext context) => const PopularScreen(),
   // '/detail': (BuildContext context) => const DetailMovieScreen(),
    '/provider': (BuildContext context) => const ProviderScreen(),
    '/calendar': (BuildContext context) => const CalendarScreen(),
    '/register': (BuildContext context) => const RegisterScreen()
  };
}
