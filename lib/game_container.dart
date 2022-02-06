import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config_pd.dart';

class GameContainer extends StatefulWidget {
  const GameContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<GameContainer> createState() => _GameContainerState();
}

class _GameContainerState extends State<GameContainer>
    with TickerProviderStateMixin {
  List<Tween> switchTween = [];
  List<Animation<Offset>> switchAnim = [];
  List<AnimationController> switchAnimCont = [];

  @override
  void initState() {
    // Add a tween and a controller for each element
    for (int i = 0; i < 16; i++) {
      switchAnimCont.add(AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)));
      switchTween.add(Tween<Offset>(begin: Offset.zero, end: Offset.zero));
      switchAnim
          .add(switchTween[i].animate(switchAnimCont[i]) as Animation<Offset>);
    }
    super.initState();
  }

  refreshAnim(int x, int y) {
    switchAnimCont[x].reset();
    switchAnimCont[x].forward();
    switchAnimCont[y].reset();
    switchAnimCont[y].forward();
  }

  @override
  void dispose() {
    for (int i = 0; i < 16; i++) {
      switchAnimCont[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _pd = Provider.of<ConfigPd>(context);
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: _pd.tilesList.length,
        itemBuilder: (context, index) {
          return SlideTransition(
              position: switchAnim[index],
              child: GestureDetector(
                  onTap: () {
                    if (_pd.tilesList[index] != 'X' && _pd.isGameRunning) {
                      int idxOfX = _pd.tilesList.indexOf('X');
                      debugPrint('Index of X: $idxOfX');
                      int temp = (idxOfX - index);
                      debugPrint('Diff: $temp');
                      if (temp == 1) {
                        // moving right
                        debugPrint('Moving right');
                        switchTween[index].begin = const Offset(1, 0);
                        switchTween[index].end = Offset.zero;
                        switchAnimCont[index].forward();
                        switchTween[idxOfX].begin = const Offset(-1, 0);
                        switchTween[idxOfX].end = Offset.zero;
                        switchAnimCont[idxOfX].forward();

                        refreshAnim(index, idxOfX);
                      } else if (temp == -1) {
                        // moving left
                        debugPrint('Moving left');
                        switchTween[index].begin = const Offset(-1, 0);
                        switchTween[index].end = Offset.zero;
                        switchAnimCont[index].forward();
                        switchTween[idxOfX].begin = const Offset(1, 0);
                        switchTween[idxOfX].end = Offset.zero;
                        switchAnimCont[idxOfX].forward();

                        refreshAnim(index, idxOfX);
                      } else if (temp == 4) {
                        // moving down
                        debugPrint('Moving down');
                        switchTween[index].begin = const Offset(0, 1);
                        switchTween[index].end = const Offset(0, 0);
                        switchAnimCont[index].forward();
                        switchTween[idxOfX].begin = const Offset(0, -1);
                        switchTween[idxOfX].end = const Offset(0, 0);
                        switchAnimCont[idxOfX].forward();

                        refreshAnim(index, idxOfX);
                      } else if (temp == -4) {
                        // moving up
                        debugPrint('Moving up');
                        switchTween[index].begin = const Offset(0, -1);
                        switchTween[index].end = const Offset(0, 0);
                        switchAnimCont[index].forward();
                        switchTween[idxOfX].begin = const Offset(0, 1);
                        switchTween[idxOfX].end = const Offset(0, 0);
                        switchAnimCont[idxOfX].forward();

                        refreshAnim(index, idxOfX);
                      }
                      _pd.moveTile(index);
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: Container(
                          decoration: BoxDecoration(
                              color: _pd.tilesList[index] == 'X'
                                  ? Colors.blue[50]
                                  : const Color(0xff0468d7),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                              child: Text(_pd.tilesList[index],
                                  textScaleFactor: 1.5,
                                  style: TextStyle(
                                      color: _pd.tilesList[index] == 'X'
                                          ? Colors.blue[50]
                                          : Colors.white,
                                      fontWeight: FontWeight.bold)))))));
        });
  }
}
