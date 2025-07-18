import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IndexHomeScreen extends StatelessWidget {
  const IndexHomeScreen({super.key});

  Widget _statColumn(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example achievement dialog (you can implement it later)
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('New Badge Unlocked!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.trophy, size: 48),
                  SizedBox(height: 8),
                  Text('Grid Commander'),
                  Text('You have mastered the art of the grid.'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
        child: const Icon(FontAwesomeIcons.gift),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                '2048 Stages',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'Master the grid, unlock achievements',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              // Gradient Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade300, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: Icon(
                                FontAwesomeIcons.trophy,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.amber,
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Grid Master',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                            'Grid Commander',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _statColumn(
                          FontAwesomeIcons.star,
                          '12,350',
                          'Total XP',
                          Colors.yellow.shade300,
                        ),
                        _statColumn(
                          FontAwesomeIcons.medal,
                          '8/20',
                          'Badges',
                          Colors.yellow.shade300,
                        ),
                        _statColumn(
                          FontAwesomeIcons.fire,
                          '7',
                          'Day Streak',
                          Colors.yellow.shade300,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Stage Progress
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.trophy,
                          color: Colors.blue,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Stage Progress",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.purple.shade200,
                              child: Icon(
                                FontAwesomeIcons.trophy,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.amber,
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grid Commander',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text('stage 5'),
                          ],
                        ),
                        SizedBox(width: 110),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, size: 16),
                          color: Colors.black,
                          onPressed: () {
                            // Show more info about the achievement
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress to next stage',
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        ),

                        Text(
                          '2,350 / 3,000 XP',
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 2350 / 3000,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 8),

                    Center(
                      child: Text(
                        '650 XP needed for next stage',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Quick Play
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.green),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.play_arrow_outlined, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Quick Play',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.grid_view, color: Colors.white),
                            SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Start New Game',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Badges & Profile
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: const [
                          Icon(FontAwesomeIcons.medal),
                          SizedBox(height: 8),
                          Text('Badges'),
                          Text('8/20'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: const [
                          Icon(FontAwesomeIcons.user),
                          SizedBox(height: 8),
                          Text('Profile'),
                          Text('View Stats'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Leaderboard & Daily Challenge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.trophy),
                    label: Text('Leaderboard'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.calendar),
                    label: Text('Daily Challenge'),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Stage List (Scrollable)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  final isLocked = index > 2;
                  return Card(
                    elevation: isLocked ? 1 : 4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isLocked
                            ? Colors.grey.shade300
                            : Theme.of(context).colorScheme.primaryContainer,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isLocked
                                ? Colors.grey.shade700
                                : Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      title: Text('Stage ${index + 1}'),
                      subtitle: const Text('Classic 4x4 Grid'),
                      trailing: Icon(
                        isLocked
                            ? FontAwesomeIcons.lock
                            : FontAwesomeIcons.play,
                        color: isLocked ? Colors.grey : Colors.green,
                      ),
                      onTap: isLocked ? null : () {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
