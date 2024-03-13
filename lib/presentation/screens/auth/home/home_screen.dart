import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumper/presentation/screens/auth/cart/cart_screen.dart';
import 'package:jumper/presentation/screens/auth/home/product_screen.dart';
import 'package:jumper/presentation/screens/auth/home/profile_screen.dart';
import 'package:jumper/presentation/screens/auth/home/user_feed_screen.dart';
import 'package:jumper/presentation/widgets/side_drawer.dart';
import '../add_product_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    ProductScreen(),
    CategoryScreen(),
    AddProductScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white, // Set app bar color to white
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 8, 65, 8),
                child: Text(
                  'Jumper',
                  style: GoogleFonts.atma(
                    textStyle: const TextStyle(color: Colors.black),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),

          // Search button
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
              color: Colors.black, // Set search icon color to black
            ),
          ),

          // Cart button
          IconButton(
            onPressed: () {
              // showModalBottomSheet(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return Container(
              //       decoration: const BoxDecoration(
              //         borderRadius:
              //             BorderRadius.vertical(top: Radius.circular(20)),
              //         color: Colors.white, // Set the background color
              //       ),
              //       height: MediaQuery.of(context).size.height *
              //           1, // Set the height as needed
              //       child: const CartScreen(),
              //     );
              //   },
              // );
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: const Icon(
              CupertinoIcons.cart_fill,
              color: Colors.black, // Set cart icon color to black
            ),
          ),
        ],
      ),
      drawer: const SideDrawer(),
      body: screens[currentIndex],
      bottomNavigationBar: FloatingNavbar(
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.shopping_bag, title: 'Products'),
          FloatingNavbarItem(icon: Icons.category, title: 'Categories'),
          FloatingNavbarItem(icon: Icons.admin_panel_settings, title: 'Admin'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
