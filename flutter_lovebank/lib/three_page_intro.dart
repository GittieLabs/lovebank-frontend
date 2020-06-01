import 'package:flutter/material.dart';


class ThreePageIntro extends StatefulWidget {


  @override
    _ThreePageIntroState createState() => _ThreePageIntroState();
}

class _ThreePageIntroState extends State<ThreePageIntro> {
  int page = 1;

  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(flex: 31),
              Container(
                padding: EdgeInsets.only(left: 60, right: 60),
                  child: Text("Improve your relationship with measurable expresions of love",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Helvetica',
                  ),
                ),
              ),
              Spacer(flex: 5),
              Container(
                child: Text("LoveBank",
                textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 58,
                    fontFamily: 'AdobeMingStd',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Spacer(flex: 31),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacer(),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacer(),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacer(flex: 31),
              ],
            ),
            Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
