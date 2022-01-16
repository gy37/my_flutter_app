import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        // primaryColor: Colors.white, //primaryColor没有效果
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
      routes: {
        '/words': (BuildContext context) => const RandomWords(),
        '/update': (BuildContext context) => const UpdateWidgetPage(),
        '/animate': (BuildContext context) => const AnimationPage(title: 'Fade Demo'),
        '/paint': (BuildContext context) => const PaintPage(),
        '/network': (BuildContext context) => const NetWorkPage(),
        '/isolate': (BuildContext context) => const IsolatePage(),
        '/asset': (BuildContext context) => const AssetPage(),
        '/gesture': (BuildContext context) => const GesturePage(),
        '/textField': (BuildContext context) => const TextFieldPage(),
      },
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', 'US'),
      // ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: getButtons(context),
    );
  }

  Widget getButtons(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 20.0,
      children: [
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转列表页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/words');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转状态修改页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/update');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转动画页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/animate');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转绘制页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/paint');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转网络页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/network');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转Isolate页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/isolate');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转资源页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/asset');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转手势页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/gesture');
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('跳转输入框页'),
          onPressed: () {
            Navigator.of(context).pushNamed('/textField');
          },
        ),
      ],
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list)),
          IconButton(onPressed: _pushIOS, icon: const Icon(Icons.share)),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final tiles = _saved.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
      }),
    );
  }

  void _pushIOS() {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (BuildContext context) {
    //     // return const UpdateWidgetPage();
    //     // return const AnimationPage(title: 'Fade Demo',);
    //     return const PaintPage();
    //   }),
    // );
    Navigator.of(context).pushNamed('/network');
  }
}


class UpdateWidgetPage extends StatefulWidget {
  const UpdateWidgetPage({ Key? key }) : super(key: key);

  @override
  _UpdateWidgetPageState createState() => _UpdateWidgetPageState();
}

class _UpdateWidgetPageState extends State<UpdateWidgetPage> {
  String textToShow = 'I like Flutter';
  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iOS App'),
      ),
      body: Center(
        child: _renderText(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: const Icon(Icons.update),
      ),
    );
  }

  void _updateText() {
    setState(() {
      textToShow = 'Flutter is Awesome!';
    });
    Future.delayed(const Duration(seconds: 3), () {
      _toggle();
    });
  }

  void _toggle() {
    setState(() {
      toggle = !toggle;
    });
  }
  Text? _renderText() {
    if (toggle) {
      return Text(textToShow);
    } else {
      return null;
    }
  }
}


class AnimationPage extends StatefulWidget {
  const AnimationPage({ Key? key, this.title }) : super(key: key);
  final title;
  
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(
        child: FadeTransition(
          opacity: curve,
          child: const FlutterLogo(size: 100.0,),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Fade',
        child: const Icon(Icons.brush),
        onPressed: () {
          controller.forward();
        }
      ),
    );
  }
}


class PaintPage extends StatefulWidget {
  const PaintPage({ Key? key }) : super(key: key);

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  var _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          final localPosition = details.localPosition;
          _points = List.from(_points)..add(localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => {},
      child: CustomPaint(
        painter: SignatuePainter(_points),
        size: Size.infinite,
      ),
    );
  }
}

class SignatuePainter extends CustomPainter {
  SignatuePainter(this.points);

  final points;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    // for (int i = 0; i < points.length - 1; i++) {
    //   if (points[i] != null && points[i + 1] != null) {
    //     canvas.drawLine(points[i], points[i + 1], paint);
    //   }
    // }
    // canvas.drawRect(const Rect.fromLTWH(100.0, 100.0, 100.0, 100.0), paint);
    canvas.drawCircle(const Offset(100.0, 100.0), 100.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}


class NetWorkPage extends StatefulWidget {
  const NetWorkPage({ Key? key }) : super(key: key);

  @override
  _NetWorkPageState createState() => _NetWorkPageState();
}

class _NetWorkPageState extends State<NetWorkPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Demo'),
      ),
      body: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
      ),
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('Row ${widgets[i]['title']}'),
    );
  }

  void loadData() async {
    const dataUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(Uri.parse(dataUrl));
    setState(() {
      widgets = jsonDecode(response.body);
    });
  }
}


class IsolatePage extends StatefulWidget {
  const IsolatePage({ Key? key }) : super(key: key);

  @override
  _IsolatePageState createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;
    ReceivePort response = ReceivePort();
    sendPort.send(['https://jsonplaceholder.typicode.com/posts', response.sendPort]);
    List msg = await response.first;
    // await sendReceive(
    //   sendPort,
    //   'https://jsonplaceholder.typicode.com/posts',
    // );
    setState(() {
      widgets = msg;
    });
    // String dataUrl = 'https://jsonplaceholder.typicode.com/posts';
    // http.Response response = await http.get(Uri.parse(dataUrl));
    // setState(() {
    //   widgets = jsonDecode(response.body);
    // });
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
  
  bool showLoadingDialog() {
    if (widgets.isEmpty) {
      return true;
    }
    return false;
  }

  Widget getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  ListView getListView() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      }
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('Row ${widgets[i]['title']}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Demo'),
      ),
      body: getBody(),
    );
  }


  static dataLoader(SendPort sendPort) async {//SendPort发送消息给ReceivePort
    ReceivePort port = ReceivePort();//ReceivePort保存接收的消息直至被监听，只能被一个监听者监听；
    sendPort.send(port.sendPort);
    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];
      String dataUrl = data;
      http.Response response = await http.get(Uri.parse(dataUrl));
      replyTo.send(jsonDecode(response.body));
    }
  }
}


class AssetPage extends StatelessWidget {
  const AssetPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Demo'),
      ),
      body: const Image(
        image: AssetImage('images/1@2x.png')
      ),
    );
  }
}


class GesturePage extends StatefulWidget  {
  const GesturePage({ Key? key }) : super(key: key);

  @override
  _GesturePageState createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Demo'),
      ),
      body: GestureDetector(
        child: RotationTransition(
          turns: curve,
          child: const FlutterLogo(size: 200,),
        ),
        onTap: () {
          if (kDebugMode) {
            print('onTap: tapped logo.');
          }
        },
        onDoubleTap: () {
          if (kDebugMode) {
            print('onDoubleTap: tapped logo.');
          }
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        onLongPress: () {
          if (kDebugMode) {
            print('onLongPress: tapped logo.');
          }
        }
      )
    );
  }
}


class TextFieldPage extends StatefulWidget {
  const TextFieldPage({ Key? key }) : super(key: key);

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final textController = TextEditingController();
  String? _errorText;
  
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: '请输入文本内容',
            errorText: _errorText,
          ),
          onSubmitted: (String text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                content: Text(textController.text),
              );
            }
          );
        },
        tooltip: 'show me the value',
        child: const Icon(Icons.text_fields),
      ),
    );
  }

  bool isEmail(String emailString) {
    String emailRegexp = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailRegexp);
    return regExp.hasMatch(emailString);
  }
}
