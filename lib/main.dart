import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

int selectedPage = 0;

var _navPages = [
  {"title": "Home", "class": HomePage()},
  {"title": "Page 1", "class": Page1()},
  {"title": "Page 2", "class": Page2()},
  {"title": "Page 3", "class": Page3()},
];

ValueNotifier<Map> _pageObj = ValueNotifier<Map>({});

void main() {
  runApp(MyApp());
  Future.delayed(Duration.zero,
      () => html.window.history.pushState(null, "Home", '/Home'.toLowerCase()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String pageTitle = "FlutterNav - Home";
  String pageName = "Home";

  @override
  void initState() {
    _pageObj.addListener(() {
      changePageTitle(_pageObj.value["title"]);
    });
  }

  void changePageTitle(String title) {
    setState(() {
      pageTitle = "FlutterNav - " + title;
      pageName = title;
      html.window.history.pushState(
          null, title, '/' + title.replaceAll(" ", "-").toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: pageTitle,
        home: Scaffold(
          appBar: CustomAppBar(),
          body: _pageObj.value["class"] ?? HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Home',
        style: GoogleFonts.nunito(
          color: Colors.black,
        ),
      ),
      color: Colors.white,
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Page 1',
        style: GoogleFonts.nunito(
          color: Colors.black,
        ),
      ),
      color: Colors.green,
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Page 2',
        style: GoogleFonts.nunito(
          color: Colors.black,
        ),
      ),
      color: Colors.cyan,
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Page 3',
        style: GoogleFonts.nunito(
          color: Colors.black,
        ),
      ),
      color: Colors.orange,
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  void changePage(int page) {
    setState(() {
      selectedPage = page;
      _pageObj.value = _navPages[selectedPage];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'FlutterNav',
        style: GoogleFonts.nunito(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                for (var i = 0; i < _navPages.length; i++)
                  TextButton(
                    onPressed: () {
                      changePage(i);
                    },
                    child: Text(
                      _navPages[i]["title"].toString(),
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight:
                              selectedPage == i ? FontWeight.bold : null),
                    ),
                  )
              ],
            )),
      ],
      centerTitle: false,
      backgroundColor: Colors.white,
    );
  }
}
