import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_localizations/flutter_localizations.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[]; //数据源，数组
  final _biggerFont = const TextStyle(fontSize: 18.0); //字体
  final _saved = <WordPair>{}; //保存的值，集合

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
      //每个数据都会调用一次，将数据渲染为Item
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        //渲染的数据个数超过数据源的数量时，新增10个数据到数据源中
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        // return Text(_suggestions[index].asPascalCase);
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
  const UpdateWidgetPage({Key? key}) : super(key: key);

  @override
  _UpdateWidgetPageState createState() => _UpdateWidgetPageState();
}

class _UpdateWidgetPageState extends State<UpdateWidgetPage> {
  String textToShow = 'I like Flutter';
  bool toggle = true;
  int pressedCount = 0;

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
        tooltip: 'Update Text ' + pressedCount.toString(),
        child: const Icon(Icons.update),
      ),
    );
  }

  void _updateText() {
    setState(() {
      textToShow = 'Flutter is Awesome!';
      pressedCount += 1;
    });
    // Future.delayed(const Duration(seconds: 3), () {
    _toggle();
    // });
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
  const AnimationPage({Key? key, this.title}) : super(key: key);
  final title;

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;
  int pressedCount = 0;

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FadeTransition(
          opacity: curve,
          child: const FlutterLogo(
            size: 100.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Fade',
          child: const Icon(Icons.brush),
          onPressed: () {
            if (pressedCount.isOdd) {
              controller.forward();
            } else {
              controller.reverse();
            }
            setState(() {
              pressedCount += 1;
            });
          }),
    );
  }
}

class PaintPage extends StatefulWidget {
  const PaintPage({Key? key}) : super(key: key);

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
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
    // canvas.drawRect(const Rect.fromLTWH(100.0, 100.0, 100.0, 100.0), paint);
    // canvas.drawCircle(const Offset(100.0, 100.0), 100.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class NetWorkPage extends StatefulWidget {
  const NetWorkPage({Key? key}) : super(key: key);

  @override
  _NetWorkPageState createState() => _NetWorkPageState();
}

class _NetWorkPageState extends State<NetWorkPage> {
  List posts = [];

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
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        },
      ),
    );
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('Row ${posts[i]['title']}'),
    );
  }

  void loadData() async {
    const dataUrl = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(Uri.parse(dataUrl));
    setState(() {
      posts = jsonDecode(response.body);
    });
  }
}

class IsolatePage extends StatefulWidget {
  const IsolatePage({Key? key}) : super(key: key);

  @override
  _IsolatePageState createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  List posts = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    ReceivePort receivePort = ReceivePort(); //r1 s1
    await Isolate.spawn(dataLoader, receivePort.sendPort); //r1.s1
    SendPort sendPort = await receivePort.first; //接受到sendPort //r2.s2
    ReceivePort response = ReceivePort(); //r3 s3
    sendPort.send([
      'https://jsonplaceholder.typicode.com/posts',
      response.sendPort
    ]); //r2.s2.send('', r3.s3)
    List msg = await response.first;
    // await sendReceive(
    //   sendPort,
    //   'https://jsonplaceholder.typicode.com/posts',
    // );
    setState(() {
      posts = msg;
    });
    // String dataUrl = 'https://jsonplaceholder.typicode.com/posts';
    // http.Response response = await http.get(Uri.parse(dataUrl));
    // setState(() {
    //   widgets = jsonDecode(response.body);
    // });
  }

  //isolate 运行在单独的线程上，可以处理耗时操作，比如网络请求，解析JSON等
  static dataLoader(SendPort sendPort) async {
    //SendPort发送消息给ReceivePort
    ReceivePort port =
        ReceivePort(); //ReceivePort保存接收的消息直至被监听，只能被一个监听者监听；//r2, s2
    sendPort.send(port.sendPort); //把sendPort作为消息发送 // r1.s1.send(r2.s2)
    await for (var msg in port) {
      String dataUrl = msg[0]; //url
      SendPort replyTo = msg[1]; //sendPort //r3.s3
      http.Response response = await http.get(Uri.parse(dataUrl));
      replyTo.send(jsonDecode(response.body)); //r3.s3.send('')
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }

  bool showLoadingDialog() {
    if (posts.isEmpty) {
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
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        });
  }

  Widget getRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('Row ${posts[i]['title']}'),
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
}

class AssetPage extends StatelessWidget {
  const AssetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Demo'),
      ),
      body: const Image(image: AssetImage('images/1@2x.png')),
    );
  }
}

class GesturePage extends StatefulWidget {
  const GesturePage({Key? key}) : super(key: key);

  @override
  _GesturePageState createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;
  double currentX = 0;
  double currentY = 0;

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
    if (kDebugMode) {
      print(currentX);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gesture Demo'),
        ),
        body: GestureDetector(
          child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: currentX,
                    top: currentY,
                    child: RotationTransition(
                        turns: curve,
                        child: const FlutterLogo(
                          size: 200,
                        )),
                  ),
                ],
              )),
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
          },
          onPanUpdate: (details) {
            setState(() {
              currentX += details.delta.dx;
              currentY += details.delta.dy;
            });
          },
        ));
  }
}

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  _TextFieldPageState createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  final textController = TextEditingController();
  String? _errorText;
  String inputText = '';

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: '请输入文本内容',
              errorText: _errorText,
            ),
            onChanged: (String text) {
              setState(() {
                inputText = text;
              });
            },
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
          Text(
            inputText,
            // textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'MontserratAlternatesItalic',
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(textController.text),
                );
              });
        },
        tooltip: 'show me the value',
        child: const Icon(Icons.text_fields),
      ),
    );
  }

  bool isEmail(String emailString) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailRegexp);
    return regExp.hasMatch(emailString);
  }
}
