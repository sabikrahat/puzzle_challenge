import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';
import 'package:puzzle_challenge/config_pd.dart';

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
                            fontSize: 26.0,
                            wordSpacing: 3.0,
                            fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10.0),
                    Text.rich(TextSpan(
                        text: _pd.moves.toString(),
                        style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff0468d7),
                            fontWeight: FontWeight.w800),
                        children: [
                          const TextSpan(
                              text: ' Moves | ',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0468d7),
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: _pd.getTiles.toString(),
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0468d7),
                                  fontWeight: FontWeight.w800)),
                          const TextSpan(
                              text: ' Tiles',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xff0468d7),
                                  fontWeight: FontWeight.w600)),
                        ])),
                    if (_pd.winState != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(_pd.winState!,
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.greenAccent[400],
                                fontWeight: FontWeight.w600)),
                      ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
                        child: GameScreen()),
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
                                textScaleFactor: 1.15,
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

class GameScreen extends StatelessWidget {
  const GameScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _pd = Provider.of<ConfigPd>(context);
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 7.0, mainAxisSpacing: 7.0),
        itemCount: _pd.tilesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => _pd.moveTile(index),
              child: Container(
                  decoration: BoxDecoration(
                      color: _pd.tilesList[index] == 'X'
                          ? Colors.white
                          : const Color(0xff0468d7),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                      child: Hero(
                          tag: 'Puzzle-Text',
                          child: Text(_pd.tilesList[index],
                              textScaleFactor: 1.5,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))))));
        });
  }
}
