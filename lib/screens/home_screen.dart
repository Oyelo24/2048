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

  // Track pan start and end for unified gesture handling
  Offset? _panStart;

  void _onPanStart(DragStartDetails details) {
    _panStart = details.localPosition;
  }

  void _onPanEnd(DragEndDetails details) {
    _panStart = null;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_panStart == null) return;
    final Offset delta = details.localPosition - _panStart!;
    if (delta.distance < 20) return; // Ignore small moves

    // Determine the main direction
    if (delta.dx.abs() > delta.dy.abs()) {
      if (delta.dx > 0) {
        moveRight();
      } else {
        moveLeft();
      }
    } else {
      if (delta.dy > 0) {
        moveDown();
      } else {
        moveUp();
      }
    }
    _panStart = null; // Prevent multiple moves per gesture
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
      backgroundColor: Colors.white,
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
       
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Score: $score', style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 189, 80, 80))),
                  SizedBox(width: 20),
                  Text('Best: $bestScore', style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 189, 80, 80))),
                ],
              ),
            ),
            SizedBox(height: 40.0,),
            Column(
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
          ],
        ),
      ),
    );
  }

  Color getColor(int value) {
    switch (value) {
      case 0:
        return Color(0xFFEEE4DA); // Light beige for empty tiles
      case 2:
        return Color(0xFFE53935); // Red
      case 4:
        return Color(0xFFFFB300); // Amber
      case 8:
        return Color(0xFFFFA726); // Orange
      case 16:
        return Color(0xFF43A047); // Green
      case 32:
        return Color(0xFF1976D2); // Blue
      case 64:
        return Color(0xFF512DA8); // Deep Purple
      case 128:
        return Color(0xFF00897B); // Teal
      case 256:
        return Color(0xFF8D6E63); // Brown
      case 512:
        return Color(0xFFEC407A); // Pink
      case 1024:
        return Color(0xFF00ACC1); // Cyan
      case 2048:
        return Color(0xFFFFEB3B); // Yellow
      default:
        return Color(0xFFCDC1B4); // Default tile color (soft beige)
    }
  }
}
