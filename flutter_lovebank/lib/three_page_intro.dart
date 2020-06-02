import 'package:flutter/material.dart';
import 'wide_button.dart';

///The three dot indicator at the bottom of the page.
///  Transparent if page is passed in as 0.
class ThreeDots extends StatelessWidget {
  final int page;
  ThreeDots({this.page});

  @override
  Widget build(BuildContext context) {
    Color w = Colors.white;
    Color r = Colors.red;
    Color t = Colors.transparent;

    Color c1 = (page == 0) ? t : (page == 1) ? r : w;
    Color c2 = (page == 0) ? t : (page == 2) ? r : w;
    Color c3 = (page == 0) ? t : (page == 3) ? r : w;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(flex: 31),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: c1,
            shape: BoxShape.circle,
          ),
        ),
        Spacer(),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: c2,
            shape: BoxShape.circle,
          ),
        ),
        Spacer(),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: c3,
            shape: BoxShape.circle,
          ),
        ),
        Spacer(flex: 31),
      ],
    );
  }
}

///The title bar at the bottom of the page complete
///  with ThreeDots. If page is passed in as 0, the
///  ThreeDots at the bottom is made transparent.
class BottomTitleBar extends StatelessWidget {
  final int page;
  BottomTitleBar({this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        ThreeDots(page: page),
      ],
    );
  }
}

///The three page intro screen widget.
class ThreePageIntro extends StatefulWidget {

  @override
  _ThreePageIntroState createState() => _ThreePageIntroState();
}

///The state of the three page intro screen widget.
class _ThreePageIntroState extends State<ThreePageIntro> {
  int _page = 1;

  void _handleTap() {
    setState(() {
      _page = (_page % 3) + 1;
    });
  }

  Widget build(BuildContext context) {
    Container mainContent = Container();
    String text = "";
    String imgPath = "";
    if (_page == 1) {
        text = "Improve your relationship with measurable expresions of love";
        imgPath = "assets/images/intro/intro-1.png";
    }
    if (_page == 2) {
        text = "Increase your love bank account by performing the tasks most important to your partner";
        imgPath = "assets/images/intro/intro-2.png";
    }

    mainContent = Container(
      padding: EdgeInsets.only(left: 60, right: 60, bottom: 60),
      child: Text( text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Helvetica',
        ),
      ),
    );

    if (_page == 3) {
        mainContent = Container(
          child: Column(
            children: [
              Padding( padding: EdgeInsets.all(10),
                child: WideButton(
                  text: "Sign in",
                  color: Theme.of(context).primaryColor,
                  onTap: _handleTap,
                ),
              ),
              Padding( padding: EdgeInsets.all(10),
                child: WideButton(
                  text: "Create an account",
                  color: Theme.of(context).accentColor,
                  onTap: _handleTap,
                ),
              ),
            ],
          ),
        );
        imgPath = "assets/images/intro/intro-3.png";
    }

    return GestureDetector(
      onTap: _handleTap,
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(imgPath),
              fit: BoxFit.cover,
            ),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              mainContent,
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
                child: BottomTitleBar(page: _page),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
