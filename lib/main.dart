import 'package:flutter/material.dart';
import 'package:jumper/presentation/screens/auth/login_screen.dart';
import 'core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Jumper());
}

class Jumper extends StatelessWidget {
  const Jumper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: LoginScreen.routeName,
    );
  }
}
