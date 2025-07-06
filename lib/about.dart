
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final String githubUrl = 'https://github.com/Oyelo24';
  final String linkedinUrl = 'https://www.linkedin.com/in/oyelowo-olayiwola-a6b6202aa/';
  final String email = 'olayiwolasolomon96@gmail.com';

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
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.videogame_asset),
                text: 'About Game',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'About Developer',
              ),
            ],
            indicatorColor: Color.fromARGB(255, 172, 134, 134),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Connect with me',
                          style: TextStyle(fontSize: 16, color: Colors.teal, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            _buildContactCard(
                              icon: FontAwesomeIcons.github,
                              title: "GitHub Profile",
                              subtitle: "@Oyelo24",
                              url: "https://github.com/Oyelo24",
                            ),
                            const SizedBox(height: 12),
                            _buildContactCard(
                              icon: FontAwesomeIcons.linkedin,
                              title: "LinkedIn",
                              subtitle: "LinkedIn Profile",
                              url: "https://www.linkedin.com/in/oyelowo-olayiwola-a6b6202aa/",
                            ),
                            const SizedBox(height: 12),
                            _buildContactCard(
                              icon: FontAwesomeIcons.envelope,
                              title: "Email",
                              subtitle: "olayiwolasolomon96@gmail.com",
                              url: "mailto:olayiwolasolomon96@gmail.com",
                            ),
                          ],
                        ),
                      ],
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

Widget _buildContactCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required String url,
  bool fullWidth = false,
}) {
  return GestureDetector(
    onTap: () async {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    },
    child: Container(
      width: fullWidth ? double.infinity : null,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          FaIcon(icon, color: Colors.teal, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.black54)),
              ],
            ),
          )
        ],
      ),
    ),
  );
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

void launchUrlGithub(String url) async{
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

void launchEmail(String email) async {
  final Uri uri = Uri(scheme: 'mailto', path: email);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $email';
  }
}

void launchLinkedIn(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}