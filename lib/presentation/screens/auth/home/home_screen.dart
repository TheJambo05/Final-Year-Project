import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:jumper/presentation/screens/auth/cart/cart_screen.dart";
import "package:jumper/presentation/screens/auth/home/profile_screen.dart";
import "package:jumper/presentation/screens/auth/home/user_feed_screen.dart";
import "../add_product_screen.dart";
import "category_screen.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = "home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen(),
    // AddProductScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumper"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: const Icon(CupertinoIcons.cart_fill)),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.admin_panel_settings), label: "Admin"),
        ],
      ),
    );
  }
}
