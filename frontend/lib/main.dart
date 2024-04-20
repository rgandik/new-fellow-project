import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/pages/root_screen.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/widget_tree.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/onboarding_provider.dart';

const ColorScheme customColorScheme = ColorScheme(
  secondary: Color(0xFFF06D3D),
  // Define the secondary color here
  surface: Colors.white,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Color(0xFFF06D3D),
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
  primary: Color(0xFF19747E),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (_) {
        return Onboarding_Provider();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!Constants.initialized) {
      Constants().init(context);
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF19747E),
          colorScheme: customColorScheme,
          fontFamily: "Urbanist",
          textTheme: Theme.of(context).textTheme.apply(fontFamily: "Urbanist"),
          // Add more theme configurations as needed
        ),
        home: const RootScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
