import 'package:flutter/cupertino.dart';

class ConfigPd extends ChangeNotifier {
  late int moves;
  late int tiles;
  String? winState;
  bool isGameRunning = false;
  late List<String> tilesList;

  ConfigPd() {
    moves = 0;
    tiles = 15;
    winState = 'Please shuffle the board';
    isGameRunning;
    tilesList = List.generate(15, (index) => (index + 1).toString());
    tilesList.add('X');
  }

  int get getMoves => moves;

  int get getTiles {
    int cnt = 0;
    for (int i = 1; i < tilesList.length; i++) {
      if (tilesList[i-1] == (i).toString()) {
        cnt++;
      }
    }
    return cnt++;
  }

  void setMoves(int moves) {
    this.moves = moves;
    notifyListeners();
  }

  void suffle() {
    setMoves(0);
    winState = null;
    isGameRunning = true;
    tilesList.shuffle();
    notifyListeners();
  }

  void moveTile(int index) {
    if (tilesList[index] != 'X' && isGameRunning) {
      String val = tilesList[index];
      int idx = tilesList.indexOf('X');
      int temp = (idx - index).abs();
      if (temp == 1 || temp == 4) {
        tilesList[idx] = val;
        tilesList[index] = 'X';

        ///
        setMoves(getMoves + 1);
        ///
        if (getTiles == 15) {
          winState = 'You Win!';
          isGameRunning = false;
        }
        notifyListeners();
      }
    }
  }
}
