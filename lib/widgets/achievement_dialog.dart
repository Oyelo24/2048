// import 'dart:math';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../models/achievements_model.dart';

// class AchievementDialog extends StatefulWidget {
//   final Achievement achievement;

//   const AchievementDialog({super.key, required this.achievement});

//   @override
//   State<AchievementDialog> createState() => _AchievementDialogState();
// }

// class _AchievementDialogState extends State<AchievementDialog>
//     with TickerProviderStateMixin {
//   late ConfettiController _confettiController;
//   late AnimationController _pulseController;
//   late AnimationController _sparkle1Controller;
//   late AnimationController _sparkle2Controller;

//   @override
//   void initState() {
//     super.initState();
//     _confettiController =
//         ConfettiController(duration: const Duration(seconds: 2));

//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat(reverse: true);

//     _sparkle1Controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();

//     _sparkle2Controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..forward();

//     // Start confetti after a short delay
//     Future.delayed(const Duration(milliseconds: 200), () {
//       if (mounted) {
//         _confettiController.play();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _confettiController.dispose();
//     _pulseController.dispose();
//     _sparkle1Controller.dispose();
//     _sparkle2Controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         Dialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           child: Container(
//             margin: const EdgeInsets.only(top: 60), // Space for the icon
//             padding:
//                 const EdgeInsets.only(top: 80, left: 24, right: 24, bottom: 24),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Colors.purple.shade50,
//                   Colors.blue.shade50,
//                 ],
//               ),
//               borderRadius: BorderRadius.circular(16.0),
//               border: Border.all(color: Colors.purple.shade100, width: 2),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.purple.withOpacity(0.3),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 )
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ShaderMask(
//                   shaderCallback: (bounds) => LinearGradient(
//                     colors: [Colors.purple.shade600, Colors.blue.shade600],
//                   ).createShader(bounds),
//                   child: Text(
//                     widget.achievement.title,
//                     textAlign: TextAlign.center,
//                     style: theme.textTheme.headlineSmall?.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white, // This color is masked by the shader
//                     ),
//                   ),
//                 ),
//                 if (widget.achievement.name != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
//                     child: Text(
//                       widget.achievement.name!,
//                       style: theme.textTheme.titleLarge
//                           ?.copyWith(fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 const SizedBox(height: 8),
//                 Text(
//                   widget.achievement.description,
//                   textAlign: TextAlign.center,
//                   style:
//                       theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           elevation: 8,
//                           shadowColor: Colors.purple.withOpacity(0.5),
//                         ),
//                         child: Ink(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 colors: [
//                                   Colors.purple.shade500,
//                                   Colors.blue.shade500
//                                 ],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Container(
//                             alignment: Alignment.center,
//                             height: 50,
//                             child: const Text('Continue',
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     if (widget.achievement.type == AchievementType.badge) ...[
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () => Navigator.of(context).pop(),
//                           icon: Icon(FontAwesomeIcons.award,
//                               size: 16, color: Colors.purple.shade600),
//                           label: Text(
//                             'View Badge',
//                             style: TextStyle(color: Colors.purple.shade600),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             minimumSize: const Size.fromHeight(50),
//                             side: BorderSide(color: Colors.purple.shade300),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//         // Main icon with pulse and sparkles
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             // The icon itself, inside a gradient circle
//             AnimatedBuilder(
//               animation: _pulseController,
//               builder: (context, child) {
//                 final shadowValue = 5 + _pulseController.value * 10;
//                 return Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                         colors: [Colors.yellow.shade500, Colors.orange.shade500]),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.orange.withOpacity(0.5),
//                         blurRadius: shadowValue,
//                         spreadRadius: shadowValue / 2,
//                       )
//                     ],
//                   ),
//                   child: child,
//                 );
//               },
//               child: Icon(widget.achievement.icon,
//                   color: Colors.white, size: 60),
//             ),
//             // Spinning sparkles
//             Positioned(
//               top: -10,
//               right: -10,
//               child: RotationTransition(
//                   turns: _sparkle1Controller,
//                   child: const Icon(FontAwesomeIcons.solidStar,
//                       color: Colors.yellow, size: 24)),
//             ),
//             Positioned(
//               bottom: -10,
//               left: -10,
//               child: RotationTransition(
//                   turns: _sparkle2Controller,
//                   child: Icon(FontAwesomeIcons.wandMagicSparkles,
//                       color: Colors.purple.shade300, size: 20)),
//             ),
//           ],
//         ),
//         // Confetti
//         Align(
//           alignment: Alignment.topCenter,
//           child: ConfettiWidget(
//             confettiController: _confettiController,
//             blastDirection: pi / 2,
//             emissionFrequency: 0.05,
//             numberOfParticles: 20,
//             gravity: 0.1,
//           ),
//         ),
//       ],
//     );
//   }
// }