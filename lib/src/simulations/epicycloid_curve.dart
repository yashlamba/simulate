import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simulate/src/simulations/providers/epicycloid_curve_provider.dart';

GlobalKey<_EpicycloidState> globalKey = GlobalKey<_EpicycloidState>();

class EpicycloidCurveWp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EpicycloidCurveProvider(),
      child: EpicycloidCurve(),
    );
  }
}

class EpicycloidCurve extends StatefulWidget {
  @override
  _EpicycloidCurveState createState() => _EpicycloidCurveState();
}

class _EpicycloidCurveState extends State<EpicycloidCurve> {
  double factor = 0;
  double total = 0;
  bool animatefactor = false;
  bool animatepoints = false;
  bool animating = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 434.0,
      height: 924.0,
      allowFontScaling: true,
    );
    final provider = Provider.of<EpicycloidCurveProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Epicycloid Pattern (Pencil of Lines)',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: provider.animatefactor || provider.animatepoints,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  child: (!provider.animating)
                      ? Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.pause,
                          color: Colors.black,
                        ),
                  onPressed: () {
                    provider.switchAnimating();
                    // setState(() {
                    //   animating = !animating;
                    //   factor = globalKey.currentState.widget.factor;
                    //   total = globalKey.currentState.widget.total;
                    // });
                  }),
              FloatingActionButton(
                heroTag: null,
                child: Icon(
                  Icons.replay,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  provider.clear();
                  // setState(() {
                  //   if (animatefactor) {
                  //     factor = 0;
                  //   }
                  //   if (animatepoints) {
                  //     total = 0;
                  //   }
                  // });
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: !isLandscape(),
        child: parameters(
          context,
          ScreenUtil().setHeight(924 / 5),
        ),
      ),
      body: Row(
        children: [
          Container(
            width: isLandscape()
                ? 2 * MediaQuery.of(context).size.width / 3
                : MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Epicycloid(
                  // factor: provider.factor,
                  // total: provider.point,
                  // animatefactor: provider.animatefactor,
                  // animatepoints: provider.animatepoints,
                  // animating: provider.animating,
                  key: globalKey,
                  isLandscape: isLandscape(),
                ),
                Positioned(
                  left: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Animate with Factor:',
                      ),
                      Checkbox(
                        onChanged: (provider.animating)
                            ? null
                            : (_) {
                                provider.switchAnimateFactor();
                                // setState(() {
                                //   animatefactor = !animatefactor;
                                // });
                              },
                        activeColor: Colors.red,
                        value: provider.animatefactor,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Animate with Points:',
                      ),
                      Checkbox(
                        onChanged: (provider.animating)
                            ? null
                            : (_) {
                                provider.switchAnimatePoints();
                                // setState(() {
                                //   animatepoints = !animatepoints;
                                // });
                              },
                        activeColor: Colors.red,
                        value: provider.animatepoints,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isLandscape(),
            child: Expanded(
              child: parameters(
                context,
                MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isLandscape() {
    return MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height;
  }

  Container parameters(BuildContext context, num height) {
    final provider = Provider.of<EpicycloidCurveProvider>(context);
    return Container(
      height: height,
      child: Material(
        elevation: 30,
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Slider(
              min: 0,
              max: 500,
              divisions: 500,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey,
              onChanged: (provider.animating)
                  ? null
                  : (value) {
                      // setState(() {
                      //   total = double.parse(value.toStringAsFixed(1));
                      // });
                      provider.setPoints(value);
                    },
              value: provider.point,
            ),
            Center(
              child: Text(
                (animating && animatepoints)
                    ? "Points: Animating"
                    : "Points: ${provider.point.toInt()}",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Slider(
              min: 0,
              max: 51,
              divisions: 510,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: Colors.grey,
              onChanged: (provider.animating)
                  ? null
                  : (value) {
                      provider.setFactor(value);
                      // setState(() {
                      //   factor = double.parse(value.toStringAsFixed(1));
                      // });
                    },
              value: provider.factor,
            ),
            Center(
              child: Text(
                (provider.animating && provider.animatefactor)
                    ? "Factor: Animating"
                    : "Factor: ${provider.factor.toStringAsFixed(1)}",
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Epicycloid extends StatefulWidget {
  Epicycloid({
    Key key,
    // @required this.factor,
    // @required this.total,
    // @required this.animatefactor,
    // @required this.animatepoints,
    // @required this.animating,
    @required this.isLandscape,
  }) : super(key: key);

  // double factor;
  // double total;
  // final bool animatefactor;
  // final bool animatepoints;
  // final bool animating;
  final bool isLandscape;

  @override
  _EpicycloidState createState() => _EpicycloidState();
}

class _EpicycloidState extends State<Epicycloid> {
  nextStep(provider) async {
    await Future.delayed(Duration(milliseconds: 10));
    // if (this.mounted) {
    //   setState(() {
    if (provider.animatefactor) {
      provider.factor += 0.01;
    }
    if (provider.animatepoints) {
      provider.point += 0.3;
    }
    if (provider.factor > 51) {
      provider.factor = 0;
    }
    if (provider.point > 500) {
      provider.point = 0;
    }
    provider.update();
    // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EpicycloidCurveProvider>(context);
    if (provider.animating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        nextStep(provider);
      });
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.scale(
          scale: widget.isLandscape ? 0.7 : 1,
          child: CustomPaint(
            painter: EpicycloidPainter(
                provider.factor,
                provider.point,
                (widget.isLandscape
                        ? MediaQuery.of(context).size.width / 5
                        : MediaQuery.of(context).size.width / 2.4)
                    .roundToDouble(),
                (widget.isLandscape
                        ? MediaQuery.of(context).size.width / 3
                        : MediaQuery.of(context).size.width / 2)
                    .roundToDouble(),
                (MediaQuery.of(context).size.height / 3).roundToDouble(),
                Theme.of(context).accentColor),
            child: Container(),
          ),
        ),
        Visibility(
          visible: provider.animatepoints,
          child: Positioned(
            right: 15,
            top: 40,
            child: Text("Points: ${provider.point.toInt()}"),
          ),
        ),
        Visibility(
          visible: provider.animatefactor,
          child: Positioned(
            left: 12,
            top: 40,
            child: Text("Factor: ${provider.factor.toStringAsFixed(1)}"),
          ),
        ),
      ],
    );
  }
}

class EpicycloidPainter extends CustomPainter {
  List<Offset> points = [];
  double total, factor;
  double radius, tx, ty;
  Color color;

  EpicycloidPainter(
    this.factor,
    this.total,
    this.radius,
    this.tx,
    this.ty,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;

    var paint2 = Paint();
    paint2.color = color;
    paint2.strokeWidth = 1;
    double x = 2 * pi / total;
    double angle = pi;

    for (int i = 0; i < total; ++i) {
      points.add(
          Offset(radius * cos(angle), radius * sin(angle)).translate(tx, ty));
      angle = angle + x;
    }
    for (double i = 0; i < total; i += 1) {
      canvas.drawLine(points[(i % total).toInt()],
          points[((i * factor) % total).toInt()], paint2);
    }
    canvas.drawCircle(Offset(tx, ty), radius, paint);
  }

  @override
  bool shouldRepaint(EpicycloidPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(EpicycloidPainter oldDelegate) => false;
}
