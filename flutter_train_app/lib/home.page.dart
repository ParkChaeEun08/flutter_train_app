import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat.page.dart';
import 'package:flutter_train_app/station.list.page.dart';

void main() {
  runApp(const FlutterTrainApp());
}

class FlutterTrainApp extends StatelessWidget {
  const FlutterTrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Train App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _departureStation = '선택';
  String _arrivalStation = '선택';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStationSelectionBox('출발역', _departureStation, () {
                  _navigateToStationListPage('출발역');
                }),
                const SizedBox(width: 20),
                _buildStationSelectionBox('도착역', _arrivalStation, () {
                  _navigateToStationListPage('도착역');
                }),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _departureStation != '선택' && _arrivalStation != '선택'
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatPage(
                              departureStation: _departureStation,
                              arrivalStation: _arrivalStation),
                        ),
                      );
                    }
                  : null,
              child: const Text('좌석 선택'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationSelectionBox(
      String label, String station, VoidCallback onTap) {
    return Expanded(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: onTap,
              child: Text(station, style: const TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToStationListPage(String stationType) async {
    final selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StationListPage(stationType: stationType)),
    );

    if (selectedStation != null) {
      setState(() {
        if (stationType == '출발역') {
          _departureStation = selectedStation;
        } else if (stationType == '도착역') {
          _arrivalStation = selectedStation;
        }
      });
    }
  }
}
