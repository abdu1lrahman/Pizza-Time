import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pizza_time/data/models/pizza_models.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/mobileScreens/details_screen.dart';
import 'package:pizza_time/presentation/widgets/custom_search.dart';
import 'package:provider/provider.dart';
import 'package:pizza_time/presentation/providers/image_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProvider1>(context, listen: true);
    final screenWidth = MediaQuery.of(context).size.width;
    timeDilation = 2.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).title,
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
        actions: [
          IconButton(
            tooltip: S.of(context).search,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearch());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            tooltip: S.of(context).order_title,
            onPressed: () {
              Navigator.pushNamed(context, 'oreders');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'account'),
            child: CircleAvatar(
              radius: 17,
              child: ClipOval(
                child: (imageProvider.loadImage() != false)
                    ? Image.file(
                        imageProvider.image!,
                        fit: BoxFit.cover,
                        width: 39,
                        height: 39,
                      )
                    : const Icon(
                        Icons.account_circle_outlined,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: GridView.builder(
        itemCount: 8,
        padding: EdgeInsets.all(screenWidth * 0.02),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(index: index),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 248, 228, 175),
                  Color.fromARGB(255, 255, 220, 123)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: 'pizza_$index',
                    child: Image.asset(
                      products[index].image,
                    ),
                  ),
                ),
                Text(
                  products[index].title,
                  style: TextStyle(
                    // if anything went wrong in the UI you can comeback to here and change it into 18.0
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${products[index].price.toString()}.0\$",
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
