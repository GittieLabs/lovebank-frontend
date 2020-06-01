import 'package:flutter/material.dart';


class ThreePageIntro extends StatefulWidget {


  @override
    _ThreePageIntroState createState() => _ThreePageIntroState();
}

class _ThreePageIntroState extends State<ThreePageIntro> {
  int _page = 1;

  void _handleTap() {
    setState(() {
      _page = (_page % 3) + 1;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (_page == 1) ? ExactAssetImage('assets/images/intro/intro-1.png') : ((_page == 2) ? ExactAssetImage('assets/images/intro/intro-2.png') : ExactAssetImage('assets/images/intro/intro-3.png')),
              fit: BoxFit.cover,
            ),
            color: Theme.of(context).backgroundColor,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(flex: 31),
                (_page == 1 || _page == 2) ? Container(
                  padding: EdgeInsets.only(left: 60, right: 60),
                    child: Text((_page == 1) ? "Improve your relationship with measurable expresions of love" : "Increase your love bank account by performing the tasks most important to your partner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                ) : Spacer(),
                Spacer(flex: 3),
                Container(
                  child: Text("LoveBank",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
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
                      color: (_page == 1) ? Colors.red : Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: (_page == 2) ? Colors.red : Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Spacer(),
                    Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: (_page == 3) ? Colors.red : Colors.white,
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
      ),
    );
  }
}
