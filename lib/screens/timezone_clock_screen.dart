import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:timezone/timezone.dart' as tz;

class TimezoneClock extends StatefulWidget {
  const TimezoneClock({Key? key}) : super(key: key);

  @override
  State<TimezoneClock> createState() => _TimezoneClockState();
}

class _TimezoneClockState extends State<TimezoneClock> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  final List<Map<String, String>> timezones = [
    {'city': 'New York', 'timezone': 'America/New_York'},
    {'city': 'London', 'timezone': 'Europe/London'},
    {'city': 'Tokyo', 'timezone': 'Asia/Tokyo'},
    {'city': 'Sydney', 'timezone': 'Australia/Sydney'},
    {'city': 'Dubai', 'timezone': 'Asia/Dubai'},
    {'city': 'Los Angeles', 'timezone': 'America/Los_Angeles'},
  ];

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getTimeInTimezone(String timezone) {
    final location = tz.getLocation(timezone);
    final timeInZone = tz.TZDateTime.now(location);
    return DateFormat('HH:mm:ss').format(timeInZone);
  }

  String _getDateInTimezone(String timezone) {
    final location = tz.getLocation(timezone);
    final timeInZone = tz.TZDateTime.now(location);
    return DateFormat('MMM dd, yyyy').format(timeInZone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('World Clock'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade600],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Local Time Display
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade400, Colors.purple.shade700],
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Local Time',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      DateFormat('HH:mm:ss').format(_currentTime),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('EEEE, MMMM dd, yyyy').format(_currentTime),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Other Time Zones',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            // Time zones grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: timezones.length,
              itemBuilder: (context, index) {
                final timezone = timezones[index];
                return _buildTimezoneCard(
                  city: timezone['city']!,
                  timezone: timezone['timezone']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimezoneCard({required String city, required String timezone}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.cyan.shade400, Colors.blue.shade600],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              city,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getTimeInTimezone(timezone),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _getDateInTimezone(timezone),
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}