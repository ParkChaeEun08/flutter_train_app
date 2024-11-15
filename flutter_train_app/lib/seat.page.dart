import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  SeatPage({required this.departureStation, required this.arrivalStation});

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<bool>> seatSelection =
      List.generate(4, (_) => List.filled(15, false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('출발역: ${widget.departureStation}',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            Icon(Icons.arrow_circle_right_outlined, size: 30),
            Text('도착역: ${widget.arrivalStation}',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            SizedBox(height: 20),
            Expanded(child: _buildSeats()),
            ElevatedButton(
              onPressed: _hasSelectedSeat()
                  ? () => _showConfirmationDialog(context)
                  : null,
              child: Text('예매 하기',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeats() {
    List<String> rows = ['A', 'B', 'C', 'D'];
    return Column(
      children: [
        for (int i = 0; i < 4; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == 1 ? 20 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < 15; j++)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: j == 7 ? 8 : 4), // C, D 사이 간격 추가
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          seatSelection[i][j] = !seatSelection[i][j];
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: seatSelection[i][j]
                              ? Colors.purple
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text('${rows[i]}${j + 1}',
                                style: TextStyle(fontSize: 18))),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  bool _hasSelectedSeat() {
    for (var row in seatSelection) {
      if (row.contains(true)) {
        return true;
      }
    }
    return false;
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('예매 확인'),
          content: Text('예매를 완료하시겠습니까?'),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
