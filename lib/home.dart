import 'package:flutter/material.dart';
import 'package:notifications/services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.firebasenotificationinit();
    notificationService
        .getDevicetoken()
        .then((value) => debugPrint("fcm: $value"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background for a sleek look
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centering text vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centering text horizontally
          children: [
            // Stylish Text: "Be Happy" or any other motivational slogan
            Text(
              'You need to be happy',
              style: TextStyle(
                fontSize: 40, // Large text for impact
                fontWeight: FontWeight.bold,
                fontFamily: 'DancingScript', // Optional: a stylish font
                color: Colors.white,
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 3,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Space between the lines
            Text(
              'Believe in yourself!Okay okkkkkkkkkkkkk',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                fontFamily: 'DancingScript', // Optional: stylish font
                color: Colors.white70, // Lighter color for the second line
                letterSpacing: 2,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 2,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
