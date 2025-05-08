import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pizza_time/data/database/sql_db.dart';
import 'package:pizza_time/data/models/pizza_models.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OredersScreen extends StatefulWidget {
  const OredersScreen({super.key});

  @override
  State<OredersScreen> createState() => _OredersScreenState();
}

class _OredersScreenState extends State<OredersScreen> {
  SqlDb db = SqlDb();
  List<Map> pizzaData = [];
  bool isLoading = true;
  File? _image;
  final Set<int> selectedItems = {};

  @override
  void initState() {
    super.initState();
    _loadPizzaData();
    _loadImage();
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('user_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _loadPizzaData() async {
    List<Map> response =
        await db.readData("SELECT id, pizzaId, date FROM pizzaHot");

    setState(() {
      pizzaData = response.reversed.toList();
      isLoading = false;
    });
  }

  double _calculateTotalPrice() {
    double total = 0.0;
    for (var index in selectedItems) {
      if (index >= 0 && index < pizzaData.length) {
        int pizzaId = pizzaData[index]['pizzaId'] as int;
        if (pizzaId >= 0 && pizzaId < products.length) {
          total += products[pizzaId].price;
        }
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).order_title),
        leading: IconButton(
          tooltip: S.of(context).back,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.select_all),
            tooltip: 'Select All',
            onPressed: () {
              setState(() {
                if (selectedItems.length == pizzaData.length) {
                  // If all are already selected, deselect all
                  selectedItems.clear();
                } else {
                  // Select all items
                  selectedItems.addAll(
                      List.generate(pizzaData.length, (index) => index));
                }
              });
            },
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'account'),
            child: CircleAvatar(
              radius: 17,
              child: ClipOval(
                child: _image != null
                    ? Image.file(
                        _image!,
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
          const SizedBox(width: 10),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pizzaData.isEmpty
              ? const Center(child: Text('No pizza data available.'))
              : Stack(
                  children: [
                    ListView.builder(
                      itemCount: pizzaData.length,
                      itemBuilder: (context, index) {
                        int? pizzaId = pizzaData[index]['pizzaId'] as int?;
                        String date = pizzaData[index]['date'] as String;
                        if (pizzaId == null) {
                          return const SizedBox.shrink();
                        }
                        final bool isSelected = selectedItems.contains(index);
                        return Card(
                          child: ListTile(
                            leading: Image.asset(products[pizzaId].image),
                            title: Text(products[pizzaId].title),
                            subtitle: Text(date),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    int dbId = pizzaData[index]['id'] as int;
                                    await db.deleteData(
                                        "DELETE FROM pizzaHot WHERE id=$dbId");

                                    setState(() {
                                      pizzaData.removeAt(index);
                                      selectedItems.remove(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.highlight_remove,
                                    color: Colors.red,
                                  ),
                                ),
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedItems.add(index);
                                      } else {
                                        selectedItems.remove(index);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedItems.remove(index);
                                } else {
                                  selectedItems.add(index);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                    if (selectedItems.isNotEmpty)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Selected Items',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        const SizedBox(height: 12),
                                        ...selectedItems.map(
                                          (index) {
                                            final product = products[
                                                pizzaData[index]['pizzaId']];
                                            return ListTile(
                                              leading: Image.asset(
                                                  product.image,
                                                  width: 40),
                                              title: Text(product.title),
                                              trailing: Text(
                                                  '\$${product.price.toStringAsFixed(2)}'),
                                            );
                                          },
                                        ).toList(),
                                        const SizedBox(height: 16),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            // TODO: Trigger Stripe payment here
                                            Navigator.pop(
                                                context); // Close the bottom sheet
                                          },
                                          icon: const Icon(Icons.payment),
                                          label: Text(
                                              'Pay \$${_calculateTotalPrice().toStringAsFixed(2)}'),
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 24),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Card(
                              color: Colors.black.withOpacity(0.7),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 24.0),
                                child: Text(
                                  'Total: \$${_calculateTotalPrice().toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
    );
  }
}
