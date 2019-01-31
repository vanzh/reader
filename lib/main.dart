import 'package:flutter/material.dart';
import 'package:reader/page/book_list.dart';
import 'package:reader/router_const.dart';
import 'package:reader/util/page_view.dart';

void main() => runApp(MyApp());

var url =
    'http://api.zhuishushenqi.com/book/by-categories?gender=male&type=new&major=%E7%8E%84%E5%B9%BB&start=0&limit=50';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '书卷小说',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: '书卷'),
      routes: <String, WidgetBuilder>{
        RouterConst.bookByCategory: (context) => BookListPage(title: "玄幻")
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _goToCategory() {
    Navigator.of(context).pushNamed(RouterConst.bookByCategory);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _goToCategory,
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward_ios),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
