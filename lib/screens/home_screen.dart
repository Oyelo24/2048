import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/settings.dart';
// Update with the correct path

class Game2048 extends StatefulWidget {
  const Game2048({super.key});

  @override
  _Game2048State createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {
  // Check if the game is over (no moves left)
  bool isGameOver() {
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (grid[r][c] == 0) return false;
        if (r < gridSize - 1 && grid[r][c] == grid[r + 1][c]) return false;
        if (c < gridSize - 1 && grid[r][c] == grid[r][c + 1]) return false;
      }
    }
    return true;
  }

  // Check if 2048 tile is present
  bool has2048Tile() {
    for (var row in grid) {
      if (row.contains(2048)) return true;
    }
    return false;
  }

  // Show Game Over dialog
  void showGameOverDialog() {
    bool isNewBest = score >= bestScore;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.sentiment_dissatisfied,
                size: 48,
                color: Colors.grey[600],
              ),
              SizedBox(height: 12),
              Text(
                'Game Over',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'No more moves available. Try again!',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Final Score', style: TextStyle(fontSize: 16)),
                    Text(
                      '$score',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.yellow[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.amber, size: 20),
                        SizedBox(width: 6),
                        Text('Best Score', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Text(
                      '$bestScore',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (isNewBest) ...[
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.celebration, color: Colors.green, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'New Best Score!',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(Icons.refresh),
                  label: Text('Play Again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      grid = List.generate(
                        gridSize,
                        (_) => List.filled(gridSize, 0),
                      );
                      score = 0;
                      addRandomTile();
                      addRandomTile();
                      saveGameState();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  Game Over dialog is shown when no moves are left.
  This dialog allows the player to restart the game.
  It resets the grid and score, and adds two new random tiles.
  It also saves the current game state to SharedPreferences.
  If the player has reached 2048, a Congratulations dialog is shown instead.  
  Void gameOverDisplay(){
  Container(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Icon(Icons.error, size: 100, color: Colors.red),
  ])
  )}
  */

  // Show Congratulations dialog
  void showCongratulationsDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, size: 48, color: Colors.amber),
              SizedBox(height: 12),
              Text(
                'Congratulations!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You reached $lastMilestone!',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(Icons.arrow_forward),
                  label: Text('Continue'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Undo/Reverse functionality: store up to 5 previous states
  final List<List<List<int>>> _gridHistory = [];
  final List<int> _scoreHistory = [];
  final int maxUndo = 5;

  void reverseMove() {
    if (_gridHistory.isNotEmpty && _scoreHistory.isNotEmpty) {
      setState(() {
        grid = [
          for (var row in _gridHistory.removeLast()) [...row],
        ];
        score = _scoreHistory.removeLast();
        saveGameState();
      });
    }
  }

  // Helper to compare two grids
  bool _gridsEqual(List<List<int>> a, List<List<int>> b) {
    for (int i = 0; i < a.length; i++) {
      for (int j = 0; j < a[i].length; j++) {
        if (a[i][j] != b[i][j]) return false;
      }
    }
    return true;
  }

  static const int gridSize = 4;
  List<List<int>> grid = List.generate(
    gridSize,
    (_) => List.filled(gridSize, 0),
  );
  List<List<bool>> merged = List.generate(
    gridSize,
    (_) => List.filled(gridSize, false),
  );
  final Random random = Random();
  int score = 0;
  int bestScore = 0;
  int lastMilestone = 0;

  @override
  void initState() {
    super.initState();
    // Schedule initialization to avoid blocking UI thread
    Future.microtask(() async {
      await loadGameState();
      await loadBestScore();
    });
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
      List<List<int>> oldGrid = [
        for (var row in grid) [...row],
      ];
      int oldScore = score;
      for (int r = 0; r < gridSize; r++) {
        List<int> row = grid[r].where((n) => n != 0).toList();
        for (int i = 0; i < row.length - 1; i++) {
          if (row[i] == row[i + 1]) {
            row[i] *= 2;
            score += row[i];
            merged[r][i] = true;
            if (score > bestScore) {
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
      bool changed = !_gridsEqual(oldGrid, grid);
      int maxTile = grid
          .expand((row) => row)
          .fold(0, (prev, e) => e > prev ? e : prev);
      if (changed) {
        _gridHistory.add([
          for (var row in oldGrid) [...row],
        ]);
        _scoreHistory.add(oldScore);
        if (_gridHistory.length > maxUndo) _gridHistory.removeAt(0);
        if (_scoreHistory.length > maxUndo) _scoreHistory.removeAt(0);
        addRandomTile();
        saveGameState();
      }
      if (changed && isGameOver()) {
        Future.delayed(Duration(milliseconds: 300), showGameOverDialog);
      } else if (changed &&
          maxTile >= 2048 &&
          maxTile % 2048 == 0 &&
          maxTile != lastMilestone) {
        lastMilestone = maxTile;
        Future.delayed(Duration(milliseconds: 300), showCongratulationsDialog);
      }
    });
  }

  void moveRight() {
    setState(() {
      List<List<int>> oldGrid = [
        for (var row in grid) [...row],
      ];
      int oldScore = score;
      for (int r = 0; r < gridSize; r++) {
        List<int> row = grid[r].reversed.where((n) => n != 0).toList();
        for (int i = 0; i < row.length - 1; i++) {
          if (row[i] == row[i + 1]) {
            row[i] *= 2;
            score += row[i];
            merged[r][gridSize - 1 - i] = true;
            if (score > bestScore) {
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
      bool changed = !_gridsEqual(oldGrid, grid);
      int maxTile = grid
          .expand((row) => row)
          .fold(0, (prev, e) => e > prev ? e : prev);
      if (changed) {
        _gridHistory.add([
          for (var row in oldGrid) [...row],
        ]);
        _scoreHistory.add(oldScore);
        if (_gridHistory.length > maxUndo) _gridHistory.removeAt(0);
        if (_scoreHistory.length > maxUndo) _scoreHistory.removeAt(0);
        addRandomTile();
        saveGameState();
      }
      if (changed && isGameOver()) {
        Future.delayed(Duration(milliseconds: 300), showGameOverDialog);
      } else if (changed &&
          maxTile >= 2048 &&
          maxTile % 2048 == 0 &&
          maxTile != lastMilestone) {
        lastMilestone = maxTile;
        Future.delayed(Duration(milliseconds: 300), showCongratulationsDialog);
      }
    });
  }

  void moveUp() {
    setState(() {
      List<List<int>> oldGrid = [
        for (var row in grid) [...row],
      ];
      int oldScore = score;
      for (int c = 0; c < gridSize; c++) {
        List<int> column = [];
        for (int r = 0; r < gridSize; r++) {
          if (grid[r][c] != 0) column.add(grid[r][c]);
        }
        for (int i = 0; i < column.length - 1; i++) {
          if (column[i] == column[i + 1]) {
            column[i] *= 2;
            score += column[i];
            merged[i][c] = true;
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
      bool changed = !_gridsEqual(oldGrid, grid);
      int maxTile = grid
          .expand((row) => row)
          .fold(0, (prev, e) => e > prev ? e : prev);
      if (changed) {
        _gridHistory.add([
          for (var row in oldGrid) [...row],
        ]);
        _scoreHistory.add(oldScore);
        if (_gridHistory.length > maxUndo) _gridHistory.removeAt(0);
        if (_scoreHistory.length > maxUndo) _scoreHistory.removeAt(0);
        addRandomTile();
        saveGameState();
      }
      if (changed && isGameOver()) {
        Future.delayed(Duration(milliseconds: 300), showGameOverDialog);
      } else if (changed &&
          maxTile >= 2048 &&
          maxTile % 2048 == 0 &&
          maxTile != lastMilestone) {
        lastMilestone = maxTile;
        Future.delayed(Duration(milliseconds: 300), showCongratulationsDialog);
      }
    });
  }

  void moveDown() {
    setState(() {
      List<List<int>> oldGrid = [
        for (var row in grid) [...row],
      ];
      int oldScore = score;
      for (int c = 0; c < gridSize; c++) {
        List<int> column = [];
        for (int r = gridSize - 1; r >= 0; r--) {
          if (grid[r][c] != 0) column.add(grid[r][c]);
        }
        for (int i = 0; i < column.length - 1; i++) {
          if (column[i] == column[i + 1]) {
            column[i] *= 2;
            score += column[i];
            merged[i][c] = true;
            if (score > bestScore) {
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
      bool changed = !_gridsEqual(oldGrid, grid);
      int maxTile = grid
          .expand((row) => row)
          .fold(0, (prev, e) => e > prev ? e : prev);
      if (changed) {
        _gridHistory.add([
          for (var row in oldGrid) [...row],
        ]);
        _scoreHistory.add(oldScore);
        if (_gridHistory.length > maxUndo) _gridHistory.removeAt(0);
        if (_scoreHistory.length > maxUndo) _scoreHistory.removeAt(0);
        addRandomTile();
        saveGameState();
      }
      if (changed && isGameOver()) {
        Future.delayed(Duration(milliseconds: 300), showGameOverDialog);
      } else if (changed &&
          maxTile >= 2048 &&
          maxTile % 2048 == 0 &&
          maxTile != lastMilestone) {
        lastMilestone = maxTile;
        Future.delayed(Duration(milliseconds: 300), showCongratulationsDialog);
      }
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
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('bestScore', bestScore);
    } catch (e) {
      // Ignore errors to avoid UI lag
    }
  }

  Future<void> loadBestScore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          bestScore = prefs.getInt('bestScore') ?? 0;
        });
      }
    } catch (e) {
      // Ignore errors to avoid UI lag
    }
  }

  // Save current game state (grid and score)
  Future<void> saveGameState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<int> flatGrid = grid.expand((row) => row).toList();
      await prefs.setString('currentGrid', flatGrid.join(','));
      await prefs.setInt('currentScore', score);
    } catch (e) {
      // Ignore errors
    }
  }

  // Load current game state (grid and score)
  Future<void> loadGameState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? gridString = prefs.getString('currentGrid');
      int? savedScore = prefs.getInt('currentScore');
      if (gridString != null && savedScore != null) {
        List<String> parts = gridString.split(',');
        if (parts.length == gridSize * gridSize) {
          setState(() {
            grid = List.generate(
              gridSize,
              (i) => parts
                  .skip(i * gridSize)
                  .take(gridSize)
                  .map(int.parse)
                  .toList(),
            );
            score = savedScore;
          });
          return;
        }
      }
    } catch (e) {
      // Ignore errors
    }
    // If loading fails, start new game
    setState(() {
      grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
      score = 0;
      addRandomTile();
      addRandomTile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('2048 Game'),
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.undo, color: Colors.white),
                tooltip: 'Reverse',
                onPressed: _gridHistory.isNotEmpty && _scoreHistory.isNotEmpty
                    ? reverseMove
                    : null,
              ),
              if (_gridHistory.isNotEmpty && _scoreHistory.isNotEmpty)
                Text(
                  '${_gridHistory.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            tooltip: 'Restart',
            onPressed: () {
              setState(() {
                grid = List.generate(gridSize, (_) => List.filled(gridSize, 0));
                score = 0;
                addRandomTile();
                addRandomTile();
                saveGameState();
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.adjust_outlined,
                              size: 25,
                              color: Colors.white,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Score',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '$score',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.trophy,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Best',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '$bestScore',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Tooltip(
                          message: 'Settings',
                          child: IconButton.filled(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsScreen(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                width: 355,
                decoration: BoxDecoration(
                  color: (Colors.blueGrey).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (Colors.white).withOpacity(1),
                      blurRadius: 10,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var row in grid)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var cell in row)
                            Container(
                              margin: EdgeInsets.all(6),
                              width: 70,
                              height: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: getColor(cell),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                cell == 0 ? '' : '$cell',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: cell <= 4
                                      ? Colors.black87
                                      : Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Restart button removed from body; now only in AppBar
            ],
          ),
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
      case 4096:
        return Color(0xFFCDDC39); // Lime
      case 8192:
        return Color(0xFFB39DDB); // Light Purple
      case 16384:
        return Color(0xFF9E9D24); // Dark Yellow
      case 32768:
        return Color(0xFF8E24AA); // Deep Purple
      case 65536:
        return Color(0xFF7B1FA2); // Dark Purple
      default:
        return Color(0xFFCDC1B4); // Default tile color (soft beige)
    }
  }
}
