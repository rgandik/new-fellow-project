// import 'package:frontend/services/auth_service.dart';
// import 'package:frontend/pages/unused_pages/home_page.dart';
// import 'package:frontend/pages/login_register_page.dart';
// import 'package:flutter/material.dart';
//
// class WidgetTree extends StatefulWidget {
//   const WidgetTree({Key? key}) : super(key: key);
//
//   @override
//   State<WidgetTree> createState() => _WidgetTreeState();
// }
//
// class _WidgetTreeState extends State<WidgetTree> {
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: AuthService().authStateChanges,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return HomePage();
//         } else {
//           return const LoginPage();
//         }
//       }
//     );
//   }
// }