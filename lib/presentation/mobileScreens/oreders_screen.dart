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
        await db.readData("SELECT pizzaId, date FROM pizzaHot");
    setState(() {
      pizzaData = response.reversed.toList();
      isLoading = false;
    });
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
              : ListView.builder(
                  itemCount: pizzaData.length,
                  itemBuilder: (context, index) {
                    int? id = pizzaData[index]['pizzaId'] as int?;
                    if (id == null) {
                      return const SizedBox.shrink();
                    }
                    return Card(
                      child: ListTile(
                        leading: Image.asset(products[id].image),
                        title: Text(products[id].title),
                        subtitle: Text('${pizzaData[index]['date']}'),
                        trailing: Text('${products[id].price}.0\$'),
                      ),
                    );
                  },
                ),
    );
  }
}
