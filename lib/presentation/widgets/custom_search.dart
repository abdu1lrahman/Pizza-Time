import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pizza_time/data/models/pizza_models.dart';
import 'package:pizza_time/presentation/screens/details_screen.dart';

class CustomSearch extends SearchDelegate {
  List<String> searchTerms = [
    products[0].title,
    products[1].title,
    products[2].title,
    products[3].title,
    products[4].title,
    products[5].title,
    products[6].title,
    products[7].title,
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<int> matchIndices = [];
    for (int i = 0; i < products.length; i++) {
      if (products[i].title.toLowerCase().contains(query.toLowerCase())) {
        matchIndices.add(i);
      }
    }
    return ListView.builder(
      itemCount: matchIndices.length,
      itemBuilder: (context, index) {
        int productIndex = matchIndices[index];
        return MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(index: productIndex),
              ),
            );
          },
          child: ListTile(
            title: Text(products[productIndex].title),
            leading: Image.asset(products[productIndex].image),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<int> matchIndices = [];
    for (int i = 0; i < products.length; i++) {
      if (products[i].title.toLowerCase().contains(query.toLowerCase())) {
        matchIndices.add(i);
      }
    }
    timeDilation = 2.0;

    return ListView.builder(
      itemCount: matchIndices.length,
      itemBuilder: (context, index) {
        int productIndex = matchIndices[index];
        return MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(index: productIndex),
              ),
            );
          },
          child: ListTile(
            title: Text(products[productIndex].title),
            leading: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Hero(
                tag: 'pizza_$index',
                child: Image.asset(products[productIndex].image),
              ),
            ),
          ),
        );
      },
    );
  }
}
