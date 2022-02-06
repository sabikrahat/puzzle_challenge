import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config_pd.dart';
import 'game_container.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Puzzle Challeng',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => ConfigPd())],
          child: const HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _pd = Provider.of<ConfigPd>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Stack(children: [
          SizedBox(
              height: size.height,
              width: size.width > 500 ? 500 : size.width,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Puzzle Challenge',
                        style: TextStyle(
                            fontSize: 22.0,
                            wordSpacing: 3.0,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10.0),
                    Text.rich(TextSpan(
                        text: _pd.moves.toString(),
                        style: const TextStyle(
                            fontSize: 17.0,
                            color: Color(0xff0468d7),
                            fontWeight: FontWeight.w800),
                        children: [
                          const TextSpan(
                              text: ' Moves | ',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xff0468d7),
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: _pd.getTiles.toString(),
                              style: const TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xff0468d7),
                                  fontWeight: FontWeight.w800)),
                          const TextSpan(
                              text: ' Tiles',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xff0468d7),
                                  fontWeight: FontWeight.w600)),
                        ])),
                    if (_pd.winState != null)
                      Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(_pd.winState!,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.greenAccent[400],
                                  fontWeight: FontWeight.w600))),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 40.0),
                        child: GameContainer()),
                    ElevatedButton.icon(
                        onPressed: () => _pd.suffle(),
                        icon: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 11.0, 0.0, 8.0),
                            child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Transform.rotate(
                                    angle: 320 * math.pi / 180,
                                    child:
                                        const Icon(Icons.replay, size: 20.0)))),
                        label: const Padding(
                            padding: EdgeInsets.fromLTRB(4.0, 8.0, 15.0, 8.0),
                            child: Text("Shuffle",
                                textScaleFactor: 1.1,
                                style: TextStyle(fontWeight: FontWeight.w600))),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff0468d7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)))),
                  ])),
          Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Image.asset(
                'assets/images/sample.png',
                height: size.width * 0.2 > 150 ? 150 : size.width * 0.2,
                width: size.width * 0.2 > 150 ? 150 : size.width * 0.2,
              )),
        ])));
  }
}
