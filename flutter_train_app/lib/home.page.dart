import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat.page.dart';
import 'package:flutter_train_app/station.list.page.dart';

void main() {
  runApp(const FlutterTrainApp());
}

// Stateflulwidget 으로 변경해서 테마 모드 관리
class FlutterTrainApp extends StatefulWidget {
  const FlutterTrainApp({super.key});

  @override
  _FlutterTrainAppState createState() => _FlutterTrainAppState();
}

// 초기 테마 모드를 라이트 모드로 설정
class _FlutterTrainAppState extends State<FlutterTrainApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Train App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: HomePage(toggleTheme: _toggleTheme),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.toggleTheme});

  @override
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
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 출발역 선택
                _buildStationSelectionBox('출발역', _departureStation, () {
                  _navigateToStationListPage('출발역');
                }),
                const SizedBox(width: 20),
                // 도착역 선택
                _buildStationSelectionBox('도착역', _arrivalStation, () {
                  _navigateToStationListPage('도착역');
                }),
              ],
            ),
            const SizedBox(height: 20),
            // 좌석 선택 버튼, 출발역과 도착역이 선택되야지 활성화
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
          color: Theme.of(context).cardColor,
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

// 역 선택 페이지로 이동하는 함수
// 이미 선택한 역을 제외
  void _navigateToStationListPage(String stationType) async {
    final selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StationListPage(
                stationType: stationType,
                exclusion:
                    stationType == '출발역' ? _arrivalStation : _departureStation,
              )),
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
