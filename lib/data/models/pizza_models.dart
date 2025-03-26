import 'package:flutter/material.dart';
import 'package:pizza_time/generated/l10n.dart';

class PizzaModels {
  final String image, title, description;
  final int id, price;
  final Color color;

  PizzaModels(
    this.id,
    this.title,
    this.image,
    this.description,
    this.price,
    this.color,
  );
}

List<PizzaModels> products = [
  PizzaModels(
    1,
    S.current.vegetarian,
    'assets/images/pizza.png',
    'Loaded with bell peppers, mushrooms, onions, olives, and tomatoes',
    5,
    Colors.white,
  ),
  PizzaModels(
    2,
    S.current.Pepperoni,
    'assets/images/pizza2.png',
    'A crowd favorite topped with spicy pepperoni slices and melted cheese',
    6,
    Colors.white,
  ),
  PizzaModels(
    3,
    'BBQ Chicken',
    'assets/images/pizza3.png',
    'Grilled chicken, red onions, cilantro, and BBQ sauce on a cheesy base',
    8,
    Colors.white,
  ),
  PizzaModels(
    4,
    'Cheese pizza',
    'assets/images/pizza4.png',
    'a delicous medium sized pizza ',
    2,
    Colors.white,
  ),
  PizzaModels(
    5,
    'Margherita',
    'assets/images/pizza5.png',
    'Classic pizza with tomato sauce, fresh mozzarella, basil, and a drizzle of olive oil.',
    4,
    Colors.white,
  ),
  PizzaModels(
    6,
    'Supreme pizza',
    'assets/images/pizza3.png',
    'a delicous medium sized pizza ',
    8,
    Colors.white,
  ),
  PizzaModels(
    7,
    'Margherita pizza',
    'assets/images/pizza2.png',
    'a delicous medium sized pizza with extra cheese',
    4,
    Colors.white,
  ),
  PizzaModels(
    8,
    'Hawaiian',
    'assets/images/pizza4.png',
    'Sweet and savory combo of ham, pineapple, and mozzarella cheese',
    8,
    Colors.white,
  ),
];
