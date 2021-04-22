import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AppBarBottomDecorationPainter extends CustomPainter {
  Color color;

  AppBarBottomDecorationPainter({this.color = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);

    path.close();

    var paint2 = Paint();
    paint2.color = Colors.black.withOpacity(0.1);

    canvas.drawLine(Offset(0, (size.height / 2) + 2),
        Offset(size.width, (size.height / 2) + 2), paint2);
    canvas.drawShadow(path, Colors.black, 2, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomTopbar extends StatelessWidget {
  String title;
  Color color;
  double margin;

  static const double HEIGHT = 70;
  static const double SPIKE_HEIGHT = 20;

  CustomTopbar({this.title, this.color, this.margin = 25});

  @override
  Widget build(BuildContext context) {
    var diamondMargin = margin - 8;
    return Container(
      width: double.infinity,
      height: HEIGHT,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => Stack(
          children: [
            Positioned(
              bottom: 0,
              height: SPIKE_HEIGHT,
              left: diamondMargin,
              width: constraints.maxWidth - (diamondMargin * 2),
              child: CustomPaint(
                painter:
                    AppBarBottomDecorationPainter(color: Colors.limeAccent),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: color,
                  height: HEIGHT - (SPIKE_HEIGHT / 2),
                ),
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final double margin = 25;
    final screenSize = MediaQuery.of(context).size;
    final listHeight = screenSize.height - CustomTopbar.HEIGHT;

    return Scaffold(
      backgroundColor: Colors.limeAccent,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                width: screenSize.width,
                height: listHeight,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 60),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) => SizedBox(
                          width: double.infinity,
                          height: 500,
                          child: Padding(
                            padding: EdgeInsets.all(margin),
                            child: Card(
                              child: Center(
                                  child: Text(
                                index.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 100),
                              )),
                            ),
                          ),
                        )),
              ),
              CustomTopbar(
                title: "home",
                color: Colors.limeAccent,
                margin: margin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
