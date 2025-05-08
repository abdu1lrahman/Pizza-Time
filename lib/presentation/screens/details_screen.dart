import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizza_time/data/database/sql_db.dart';
import 'package:pizza_time/data/models/pizza_models.dart';
import 'package:pizza_time/generated/l10n.dart';
import 'package:pizza_time/presentation/widgets/customAppBar.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  int index;
  DetailsScreen({super.key, required this.index});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  SqlDb db = SqlDb();
  String? _dateTimeString;

  @override
  initState() {
    super.initState();
    _getCurrentDateTime();
  }

  void _getCurrentDateTime() {
    DateTime now = DateTime.now();
    _dateTimeString = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: customDetailsAppBar(context),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 244, 214),
            Color.fromARGB(255, 255, 220, 123)
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/plate.png'),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.026, left: screenWidth * 0.022),
                      child: Hero(
                        tag: 'pizza_${widget.index}',
                        child: Image.asset(
                          width: screenWidth * 0.611,
                          products[widget.index].image,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // 
              const SizedBox(height: 15.0),
              Text(
                products[widget.index].title.toString(),
                style: TextStyle(
                    fontSize: screenWidth * 0.056, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  products[widget.index].description.toString(),
                  style: const TextStyle(
                    fontSize: 17.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${products[widget.index].price.toString()}\$',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15),
                  MaterialButton(
                    color: Colors.red,
                    child: Text(
                      S.of(context).add_chart,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      db.insertData(
                          "INSERT INTO 'pizzaHot' ('pizzaId','date') VALUES (${widget.index},'$_dateTimeString')");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.of(context).pizza_added_successfully)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
