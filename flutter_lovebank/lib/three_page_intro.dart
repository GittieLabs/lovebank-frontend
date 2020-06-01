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
              Spacer(flex: 11),
              Container(
                padding: EdgeInsets.all(100),
                  child: Text("Improve your relationship with measurable expresions of love",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(flex: 2),
              Container(
                child: Text("Love Bank"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Spacer(flex: 13),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacer(),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacer(),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Spacer(flex: 13),
              ],
            ),
            Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
