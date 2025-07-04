import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Game2048 extends StatefulWidget {  
 const Game2048({super.key});

  @override
  _Game2048State createState() => _Game2048State();
  
}

class _Game2048State extends State<Game2048> {
  static const int gridSize = 4;
  List<List<int>> grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
  final Random random = Random();
  int score =0;
  int bestScore = 0;
 
  @override
  void initState() {
    super.initState();
    addRandomTile();
    addRandomTile();
    loadBestScore();
  }

  void addRandomTile() {
    List<Point> empty = [];
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (grid[r][c] == 0) empty.add(Point(r, c));
      }
    }
    if (empty.isNotEmpty) {
      final pos = empty[random.nextInt(empty.length)];
      grid[pos.x.toInt()][pos.y.toInt()] = random.nextInt(10) == 0 ? 4 : 2;
    }
  }

  void moveLeft() {
    setState(() {
      for (int r = 0; r < gridSize; r++) {
        List<int> row = grid[r].where((n) => n != 0).toList();
        for (int i = 0; i < row.length - 1; i++) {
          if (row[i] == row[i + 1]) {
            row[i] *= 2;
            score += row[i];
            if (score > bestScore){
              bestScore = score;
              saveBestScore();
            }
            row[i + 1] = 0;
          }
        }
        row = row.where((n) => n != 0).toList();
        while (row.length < gridSize) row.add(0);
        grid[r] = row;
      }
      addRandomTile();
    });
  }

  void moveRight() {
    setState(() {
      for (int r = 0; r < gridSize; r++) {
        List<int> row = grid[r].reversed.where((n) => n != 0).toList();
        for (int i = 0; i < row.length - 1; i++) {
          if (row[i] == row[i + 1]) {
            row[i] *= 2;
            score += row[i];
            if (score > bestScore){
              bestScore = score;
              saveBestScore();
            }
            row[i + 1] = 0;
          }
        }
        row = row.where((n) => n != 0).toList();
        while (row.length < gridSize) row.add(0);
        grid[r] = row.reversed.toList();
      }
      addRandomTile();
    });
  }

  void moveUp() {
    setState(() {
      for (int c = 0; c < gridSize; c++) {
        List<int> column = [];
        for (int r = 0; r < gridSize; r++) {
          if (grid[r][c] != 0) column.add(grid[r][c]);
        }
        for (int i = 0; i < column.length - 1; i++) {
          if (column[i] == column[i + 1]) {
            column[i] *= 2;
            score += column[i];
            if (score > bestScore) {
              bestScore = score;
              saveBestScore();
            }
            column[i + 1] = 0;
          }
        }
        column = column.where((n) => n != 0).toList();
        while (column.length < gridSize) column.add(0);
        for (int r = 0; r < gridSize; r++) {
          grid[r][c] = column[r];
        }
      }
      addRandomTile();
    });
  }

  void moveDown() {
    setState(() {
      for (int c = 0; c < gridSize; c++) {
        List<int> column = [];
        for (int r = gridSize - 1; r >= 0; r--) {
          if (grid[r][c] != 0) column.add(grid[r][c]);
        }
        for (int i = 0; i < column.length - 1; i++) {
          if (column[i] == column[i + 1]) {
            column[i] *= 2;
            score += column[i];
            if (score > bestScore){
              bestScore = score;
              saveBestScore();
              }
              column[i + 1] = 0;
          }
        }
        column = column.where((n) => n != 0).toList();
        while (column.length < gridSize) column.add(0);
        for (int r = gridSize - 1; r >= 0; r--) {
          grid[r][c] = column[gridSize - 1 - r];
        }
      }
      addRandomTile();
    });
  }

  void handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;
    if (details.primaryVelocity! < -100) moveLeft();
    else if (details.primaryVelocity! > 100) moveRight();
  }

  void handleVertical(DragUpdateDetails details) {
    if (details.primaryDelta == null) return;
    if (details.primaryDelta! < -10) moveUp();
    else if (details.primaryDelta! > 10) moveDown();
  }

  Future<void> saveBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bestScore', bestScore);
  }

  Future<void> loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs.getInt('bestScore') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 134, 134),
      appBar: AppBar(title: Text('2048 Game'),
       backgroundColor: Colors.grey[850],
       foregroundColor: Colors.white,
       actions: [
        IconButton(
          icon: Icon(Icons.info_outline, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/about');
          }
        ),
       ],),
       
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Score: $score', style: TextStyle(fontSize: 20, color: Colors.white)),
                SizedBox(width: 20),
                Text('Best: $bestScore', style: TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 40.0,),
          GestureDetector(
            onHorizontalDragEnd: handleSwipe,
            onVerticalDragUpdate: handleVertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var row in grid)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var cell in row)
                        Container(
                          margin: EdgeInsets.all(4),
                          width: 70,
                          height: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: getColor(cell),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            cell == 0 ? '' : '$cell',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: cell <= 4 ? Colors.black87 : Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => setState(() {
                    grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
                    score = 0;
                    addRandomTile();
                    addRandomTile();
                  }),
                  child: Text("Restart"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(int value) {
    switch (value) {
      case 0:
        return Colors.grey[400]!;
      case 2:
        return Colors.orange[100]!;
      case 4:
        return Colors.orange[200]!;
      case 8:
        return Colors.deepOrange[300]!;
      case 16:
        return Colors.deepOrange[400]!;
      case 32:
        return Colors.red[300]!;
      case 64:
        return Colors.red[400]!;
      case 128:
        return Colors.green[300]!;
      case 256:
        return Colors.green[400]!;
      case 512:
        return Colors.blue[300]!;
      case 1024:
        return Colors.purple[300]!;
      case 2048:
        return Colors.yellow[700]!;
      default:
        return Colors.black;
    }
  }
}
