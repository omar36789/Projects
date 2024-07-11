import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/firebase_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<String>> _holidays;

  @override
  void initState() {
    super.initState();
    _loadHolidays();
  }

  Future<void> _loadHolidays() async {
    final firebaseService =
        Provider.of<FirebaseService>(context, listen: false);
    final holidays = await firebaseService.getHolidays();
    setState(() {
      _holidays = holidays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            eventLoader: (day) {
              return _holidays[day] ?? [];
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _holidays.length,
              itemBuilder: (context, index) {
                final date = _holidays.keys.elementAt(index);
                final events = _holidays[date]!;
                return ListTile(
                  title: Text('${date.month}/${date.day}/${date.year}'),
                  subtitle: Text(events.join(', ')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
