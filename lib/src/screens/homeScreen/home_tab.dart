import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/src/screens/homeScreen/components/home_item_tile.dart';
import 'package:newravelinestore/src/utils/app_data.dart' as app_data;
import 'package:newravelinestore/src/utils/constants.dart';

import 'components/category_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectectedCategory = 'Meats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(
                text: 'Raveline',
                style: TextStyle(
                  color: Colors.teal,
                ),
              ),
              TextSpan(
                text: 'Grocery',
                style: TextStyle(
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Badge(
              badgeColor: Colors.red[700] ?? Colors.red,
              badgeContent: Text(
                '2',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              child: Icon(
                Icons.shopping_bag,
                color: Colors.teal[600],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: hintTextSearchHomeString,
                hintStyle: GoogleFonts.lato(color: Colors.grey.shade400),
                prefixIcon:
                    Icon(Icons.search, color: Colors.red[700], size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),

          //Categories
          Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.only(left: 16),
            height: MediaQuery.of(context).size.height / 10,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => CategoryTile(
                category: app_data.categories[index],
                isSelected: app_data.categories[index].toLowerCase() ==
                    selectectedCategory.toLowerCase(),
                onPressed: () {
                  setState(() {
                    selectectedCategory = app_data.categories[index];
                  });
                },
              ),
              separatorBuilder: (_, index) => const SizedBox(width: 8),
              itemCount: app_data.categories.length,
            ),
          ),

          //GridView
          Expanded(
              child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 9 / 11.5,
            ),
            itemCount: app_data.items.length,
            itemBuilder: (_, index) {
              return HomeItemTile(
                itemModel: app_data.items[index],
              );
            },
          )),
        ],
      ),
    );
  }
}
