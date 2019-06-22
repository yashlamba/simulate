import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'custom_items/home_page.dart';
import 'custom_items/physics_page.dart';
import 'custom_items/algorithms_page.dart';
import 'simulations/toothpick.dart';

class Home extends StatefulWidget {
  final List<Widget> _categoryTabs = [
    Tab(
      child: Text('Home'),
    ),
    Tab(
      child: Text('Physics'),
    ),
    Tab(
      child: Text('Algorithms'),
    ),
    Tab(
      child: Text('Mathematics'),
    ),
    Tab(
      child: Text('Chemistry'),
    ),
  ];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  TabController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Simulate',
          style: TextStyle(color: Colors.black, fontFamily: 'Ubuntu'),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _categoryController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(0.3),
          indicatorColor: Colors.black,
          tabs: widget._categoryTabs,
        ),
      ),
      body: TabBarView(
        controller: _categoryController,
        children: <Widget>[
          HomePage(),
          PhysicsPage(),
          AlgorithmsPage(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}