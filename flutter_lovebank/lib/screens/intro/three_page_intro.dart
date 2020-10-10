import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authenticate/register_sign_in.dart';
import 'package:flutterapp/screens/components/wide_button.dart';

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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(2),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: c1,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: c2,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: c3,
              shape: BoxShape.circle,
            ),
          ),
        ),
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
          child: Text(
            "LoveBank",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontFamily: 'AbhayaLibre',
            ),
          ),
        ),
        ThreeDots(page: page),
      ],
    );
  }
}

///Each individual page, including
/// page 0 (the splash page).
/// Generated differently depending
/// on the value of page passed in.
class IntroPage extends StatelessWidget {
  final int page;
  IntroPage({this.page});

  void _loadLoginScreen(bool signIn, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RegisterSignIn(showSignIn: signIn)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Container mainContent = Container();
    String text = " ";
    String imgPath = "";
    if (page == 0) {
      imgPath = "assets/images/intro/splash.png";
    }
    if (page == 1) {
      text = "Improve your relationship with measurable expressions of love";
      imgPath = "assets/images/intro/intro-1.png";
    }
    if (page == 2) {
      text =
          "Increase your love bank account by performing the tasks most important to your partner";
      imgPath = "assets/images/intro/intro-2.png";
    }

    mainContent = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 60, right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 3),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );

    if (page == 3) {
      mainContent = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(flex: 3),
            Padding(
              padding: EdgeInsets.all(10),
              child: WideButton(
                text: "Sign in",
                color: Theme.of(context).primaryColor,
                onTap: () => {_loadLoginScreen(true, context)},
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: WideButton(
                text: "Create an account",
                color: Theme.of(context).accentColor,
                onTap: () => {_loadLoginScreen(false, context)},
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      );
      imgPath = "assets/images/intro/intro-3.png";
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(imgPath),
          fit: BoxFit.cover,
        ),
        color: Theme.of(context).backgroundColor,
      ),
      child: mainContent,
    );
  }
}

///The three page intro screen widget.
class ThreePageIntro extends StatefulWidget {
  @override
  _ThreePageIntroState createState() => _ThreePageIntroState();
}

///The state of the three page intro screen widget.
/// Also has a 2.5 second splash page.
class _ThreePageIntroState extends State<ThreePageIntro> {
  int _page = 0;
  PageController _pageController;
  List<IntroPage> pages = [
    IntroPage(page: 1),
    IntroPage(page: 2),
    IntroPage(page: 3),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (this.mounted) {
        setState(() {
          _page = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int x) {
    setState(() {
      _page = x + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          AnimatedCrossFade(
            crossFadeState: (_page == 0)
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 700),
            firstChild: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: [IntroPage(page: 0)],
              ),
            ),
            secondChild: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                onPageChanged: _changePage,
                children: pages,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: BottomTitleBar(page: _page),
          ),
        ],
      ),
    );
  }
}
