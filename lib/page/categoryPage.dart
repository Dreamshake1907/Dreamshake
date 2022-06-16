import 'package:flutter/material.dart';
import 'package:food_recipe/page/Category/Breakfast.dart';
import 'package:food_recipe/page/Category/Desserts.dart';
import 'package:food_recipe/page/Category/Drinks.dart';
import 'package:food_recipe/page/Category/FastFood.dart';
import 'package:food_recipe/page/Category/Lunch.dart';
import 'package:food_recipe/page/Category/NewAdded.dart';
import 'package:food_recipe/page/Category/Salads.dart';
import 'package:food_recipe/page/Category/Snacks.dart';
import 'package:food_recipe/page/Category/Vegan.dart';
import 'Category/baked.dart';

class catPage extends StatefulWidget {
  @override
  _catPageState createState() => _catPageState();
}

class _catPageState extends State<catPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 9, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: heigth,
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.red.shade400,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: <Widget>[
                    baked,
                    breakfast,
                    desserts,
                    drinks,
                    fastfood,
                    Lunch,
                    salads,
                    snacks,
                    vegan,
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Baked(),
                    Breakfast(),
                    Desserts(),
                    Drinks(),
                    FastFood(),
                    lunch(),
                    Salads(),
                    Snacks(),
                    Vegan(),
                  ],
                ),
              ),
              Text(
                'New Added Recipes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(child: newAdded()),
            ],
          ),
        ),
      ),
    );
  }
}

Widget baked = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/baked.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('baked'),
    ],
  ),
);

Widget breakfast = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/breakfast.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('Breakfast'),
    ],
  ),
);

Widget desserts = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/desserts.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('Desserts'),
    ],
  ),
);

Widget drinks = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/drinks.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('Drinks'),
    ],
  ),
);

Widget fastfood = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/fastfood.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('FastFood'),
    ],
  ),
);

Widget Lunch = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/lunch.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('Lunch'),
    ],
  ),
);

Widget salads = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/salads.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('Salads'),
    ],
  ),
);

Widget snacks = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/snacks.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('Snacks'),
    ],
  ),
);

Widget vegan = Container(
  child: Column(
    children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'lib/assets/vegan.jpg',
            height: 80,
            width: 80,
            fit: BoxFit.fill,
          )),
      SizedBox(
        height: 5,
      ),
      Text('Vegan'),
    ],
  ),
);
