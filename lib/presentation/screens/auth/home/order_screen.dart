import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:jumper/logic/cubits/category_cubit/category_cubits.dart";
import "package:jumper/logic/cubits/category_cubit/category_state.dart";

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState && state.categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoryErrorState && state.categories.isEmpty) {
          return Center(
            child: Text(
              state.message.toString(),
            ),
          );
        }
        ///////////////////
        ///Screen design starts from here
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Arrivals",
                  style: GoogleFonts.belleza(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Container(
                        margin: const EdgeInsets.fromLTRB(
                            0, 10, 100, 0), // Add margin between containers
                        decoration: BoxDecoration(
                          color: Colors.amber, // Change container color here
                          borderRadius: BorderRadius.circular(
                              10), // Add border radius for rounded corners
                        ),
                        child: ListTile(
                          title: Text("${category.title}"),
                          // Add onTap functionality if needed
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
