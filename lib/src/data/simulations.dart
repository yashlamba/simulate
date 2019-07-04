import 'package:flutter/material.dart';
import 'package:simulate/src/custom_items/simulation_card.dart';
import 'package:simulate/src/simulations/bubble_sort.dart';
import 'package:simulate/src/simulations/rose_pattern.dart';
import 'package:simulate/src/simulations/toothpick.dart';
import 'package:simulate/src/simulations/langton_ant.dart';
import 'package:simulate/src/simulations/insertion_sort.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Simulations with ChangeNotifier {
  static var _favorites = [-1, -1, -1, -1, -1];
  final _algorithm = [0, 1, 2, 3];
  final _mathematics = [4];
  final _physics = [];
  final _chemistry = [];
  var prefs;

  Simulations() {
    getFavorites();
  }

  getFavorites() async {
    prefs = await SharedPreferences.getInstance();
    List<String> myList = (prefs.getStringList('favorites') ?? List<String>());
    if (myList.length != 0) {
      _favorites = myList.map((i) => int.parse(i)).toList();
    }
  }

  List<Widget> allSimulations() {
    return <Widget>[
      SimulationCard(
        id: 0,
        simulationName: 'ToothPick Pattern',
        image: 'images/ToothpickPattern.gif',
        direct: ToothpickPattern(),
        infoLink: 'https://en.wikipedia.org/wiki/Toothpick_sequence',
        fav: _favorites[0],
      ),
      SimulationCard(
        id: 1,
        simulationName: 'Langton\'s Ant',
        image: 'images/LangtonsAnt.gif',
        direct: LangtonAnt(),
        infoLink: 'https://en.wikipedia.org/wiki/Langton%27s_ant',
        fav: _favorites[1],
      ),
      SimulationCard(
        id: 2,
        simulationName: 'Bubble Sort (Bars)',
        image: 'images/Bubblesort.gif',
        direct: BubbleSortBars(),
        infoLink: '',
        fav: _favorites[2],
      ),
      SimulationCard(
        id: 3,
        simulationName: 'Insertion Sort',
        image: 'images/InsertionSort.gif',
        direct: InsertionHome(),
        infoLink: 'https://en.wikipedia.org/wiki/Insertion_sort',
        fav: _favorites[3],
      ),
      SimulationCard(
        id: 4,
        simulationName: 'Rose Pattern',
        image: 'images/RosePattern.gif',
        direct: RosePattern(),
        infoLink: '',
        fav: _favorites[4],
      ),
    ];
  }

  List<Widget> get all {
    getFavorites();
    return allSimulations();
  }

  List<Widget> get algorithms {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _algorithm.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get physics {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _physics.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get mathematics {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _mathematics.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get chemistry {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    _chemistry.forEach((index) => widgets.add(allWidgets[index]));
    return widgets;
  }

  List<Widget> get favorites {
    getFavorites();
    List<Widget> widgets = [];
    List<Widget> allWidgets = allSimulations();
    for (int i = 0; i < _favorites.length; ++i) {
      if (_favorites[i] == 1) {
        widgets.add(allWidgets[i]);
      }
    }
    return widgets;
  }

  void toggleFavorite(int index) async {
    _favorites[index] *= -1;
    List<String> favorites = _favorites.map((i) => i.toString()).toList();
    await prefs.setStringList('favorites', favorites);
    notifyListeners();
  }
}
