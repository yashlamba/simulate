import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EpicycloidCurveProvider with ChangeNotifier {
  double _factor = 0;
  double _points = 0;
  bool animatefactor = false;
  bool animatepoints = false;
  bool animating = false;
  double get point => _points;
  double get factor => _factor;

  void switchAnimating() {
    animating = !animating;
    notifyListeners();
  }

  void switchAnimateFactor() {
    animatefactor = !animatefactor;
    notifyListeners();
  }

  void switchAnimatePoints() {
    animatepoints = !animatepoints;
    notifyListeners();
  }

  void setPoints(value) {
    _points = value;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  void setFactor(value) {
    _factor = value;
    notifyListeners();
  }

  set factor(value) {
    // print(1);
    this._factor = value;
  }

  set point(value) {
    this._points = value;
  }

  void clear() {
    if (animatefactor) {
      _factor = 0;
    }
    if (animatepoints) {
      _points = 0;
    }
  }
}
