import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage(
      {super.key,
      required this.departureStation,
      required this.arrivalStation});

  @override
  // ignore: library_private_types_in_public_api
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  List<List<bool>> seatSelection =
      List.generate(4, (_) => List.filled(15, false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('출발역: ${widget.departureStation}',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            const Icon(Icons.arrow_circle_right_outlined, size: 30),
            Text('도착역: ${widget.arrivalStation}',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            const SizedBox(height: 20),
            Expanded(child: _buildSeats()),
            ElevatedButton(
              onPressed: _hasSelectedSeat()
                  ? () => _showConfirmationDialog(context)
                  : null,
              child: const Text('예매 하기',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeats() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSeatHeader('A'),
              const SizedBox(width: 20),
              _buildSeatHeader('B'),
              const SizedBox(width: 40), // A/B와 C/D 사이 간격
              _buildSeatHeader('C'),
              const SizedBox(width: 20),
              _buildSeatHeader('D'),
            ],
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < 15; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSeat(i, 'A', 0),
                const SizedBox(width: 20),
                _buildSeat(i, 'B', 1),
                const SizedBox(width: 40), // A/B와 C/D 사이 간격
                SizedBox(
                  width: 40, // 고정된 너비를 줘서 좌석 위치를 일정하게 유지
                  child: Center(
                      child: Text('${i + 1}',
                          style: const TextStyle(fontSize: 18))), // 숫자 표시
                ),
                const SizedBox(width: 40), // 숫자와 C/D 사이 간격
                _buildSeat(i, 'C', 2),
                const SizedBox(width: 20),
                _buildSeat(i, 'D', 3),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSeatHeader(String rowLabel) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
          child: Text(rowLabel,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildSeat(int seatIndex, String rowLabel, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          seatSelection[index][seatIndex] = !seatSelection[index][seatIndex];
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: seatSelection[index][seatIndex]
              ? Colors.purple
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10), // 위아래 간격 추가
      ),
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
          title: const Text('예매 확인'),
          content: const Text('예매를 완료하시겠습니까?'),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('확인'),
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
