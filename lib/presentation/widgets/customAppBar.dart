import 'package:flutter/material.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/widgets/custom_search.dart';

AppBar customDetailsAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      tooltip: S.of(context).back,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.keyboard_backspace),
    ),
    title: Text(S.of(context).pizza_details),
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
    ],
  );
}
