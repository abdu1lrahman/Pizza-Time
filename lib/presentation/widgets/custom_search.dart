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
    List<String> matchQuery = [];
    for (var element in searchTerms) {
      if (element.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return MaterialButton(
          onPressed: () {},
          child: ListTile(
            title: Text(result),
            leading: Image.asset(products[index].image),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var element in searchTerms) {
      if (element.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    timeDilation = 2.0;

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(index: index),
              ),
            );
          },
          child: ListTile(
            title: Text(result),
            leading: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Hero(
                tag: 'pizza_$index',
                child: Image.asset(products[index].image),
              ),
            ),
          ),
        );
      },
    );
  }
}
