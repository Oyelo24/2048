
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
          title: const Text('About',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          bottom: TabBar(
            tabs: [
              Row(
                children: [
                  Image.asset('assets/images/pad.png', width: 24, height: 24,
                  color: Colors.white,),
                  const SizedBox(width: 4),
                  const Tab(text: 'About Game'),
                ],
              ),
              const Tab(text: 'About Developer'),
            ],
            indicatorColor: const Color.fromARGB(255, 172, 134, 134),
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 100, height: 100),
                  const SizedBox(height: 16),
                  const Text(
                    '2048 is a simple yet addictive puzzle game where the goal is to combine tiles with the same number to reach the 2048 tile.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  _InfoCard(
                    color: Colors.blue,
                    title: 'How to Play',
                    icon: Icons.adjust_outlined,
                    children: const [
                      Text('1. Swipe to move tiles. When two tiles with the same number touch, they merge into one.', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 5),
                      Text('2. Create a tile with the number 2048 to win!', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _InfoCard(
                    color: Colors.green,
                    title: 'Game Features',
                    icon: Icons.adjust_outlined,
                    children: const [
                      Text('• Simple and intuitive controls.', style: TextStyle(fontSize: 12)),
                      Text('• Undo and restart options.', style: TextStyle(fontSize: 12)),
                      Text('• High score tracking.', style: TextStyle(fontSize: 12)),
                      Text('• Beautiful UI.', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _InfoCard(
                    color: Colors.red,
                    title: 'Game Strategy Tips',
                    icon: Icons.adjust_outlined,
                    children: const [
                      Text('• You can only move tiles in one direction at a time.', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 5),
                      Text('• The game ends when there are no valid moves left.', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Olayiwola Oyelowo',
                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Passionate Flutter developer.',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About Me', style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text( 
                          'I am a Flutter developer with a passion for creating engaging and user-friendly applications. I love solving problems and continuously learning new technologies.',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Flutter',
                                  style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Dart',
                                  style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Flutter Web',
                                  style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Pocketbase',
                                  style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.grey.shade200,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Mobile Development',
                                  style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.grey, width: 1),
                            //     borderRadius: BorderRadius.circular(16),
                            //     color: Colors.grey.shade200,
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(4.0),
                            //     child: Text('Serverpod',
                            //       style: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            //     ),
                            //   ),
                            // ),
                          ],
                        )
                        ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity/2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(0.1),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Development Details',
                          style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text('Version: 1.0.0',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        const SizedBox(height: 7),
                        Text('Build Date: 2023-10-01',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        const SizedBox(height: 7),
                        Text('Built with: Flutter',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity/2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal.withOpacity(0.1),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Connect with me',
                      style: TextStyle(fontSize: 12, color: Colors.teal, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _InfoCard({
    required this.color,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}