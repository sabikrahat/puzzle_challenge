import 'package:flutter/cupertino.dart';

class ConfigPd extends ChangeNotifier {
  late int moves;
  late int tiles;

  ConfigPd() {
    moves = 0;
    tiles = 15;
  }

  int get getMoves => moves;

  int get getTiles => tiles;

  void setMoves(int moves) {
    this.moves = moves;
    notifyListeners();
  }
  
  void setTiles(int tiles) {
    this.tiles = tiles;
    notifyListeners();
  }

  void reset() {
    moves = 0;
    tiles = 15;
    notifyListeners();
  }
}
