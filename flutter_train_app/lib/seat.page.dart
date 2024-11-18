// library_private_types_in_public_api 경고를 무시함

import 'package:flutter/material.dart';

// StatefulWidget을 사용하여 좌석 선택 페이지를 만듦
class SeatPage extends StatefulWidget {
  final String departureStation; // 출발역
  final String arrivalStation; // 도착역

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  _SeatPageState createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 좌석 선택 상태를 저장하는 리스트를 생성, 초기화
  List<List<bool>> seatSelection =
      List.generate(4, (_) => List.filled(20, false));

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
            Text(
              '출발역: ${widget.departureStation}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const Icon(Icons.arrow_circle_right_outlined, size: 30),
            Text(
              '도착역: ${widget.arrivalStation}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            // 좌석을 빌드하는 함수 호출
            Expanded(child: _buildSeats()),
            // 좌석 선택 확인 버튼, 선택된 좌석이 있을 때만 활성화
            ElevatedButton(
              onPressed: _hasSelectedSeat()
                  ? () => _showConfirmationDialog(context)
                  : null,
              child: const Text(
                '예매 하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 좌석을 빌드하는 함수
  Widget _buildSeats() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSeatHeader('A'),
              const SizedBox(width: 4),
              _buildSeatHeader('B'),
              const SizedBox(width: 4),
              _buildSeatHeader('C'),
              const SizedBox(width: 4),
              _buildSeatHeader('D'),
            ],
          ),
          const SizedBox(height: 8),
          // 좌석 번호를 표시하는 위젯 빌드
          for (int i = 0; i < 20; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSeat(i, 'A', 0),
                const SizedBox(width: 4),
                _buildSeat(i, 'B', 1),
                const SizedBox(width: 4),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                _buildSeat(i, 'C', 2),
                const SizedBox(width: 4),
                _buildSeat(i, 'D', 3),
              ],
            ),
        ],
      ),
    );
  }

  // 좌석 열 레이블을 빌드하는 함수
  Widget _buildSeatHeader(String rowLabel) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: Text(
          rowLabel,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // 좌석을 빌드하고 선택 기능을 추가하는 함수
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
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }

  // 선택된 좌석이 있는지 확인하는 함수
  bool _hasSelectedSeat() {
    for (var row in seatSelection) {
      if (row.contains(true)) {
        return true;
      }
    }
    return false;
  }

  // 예매 확인 대화 상자를 표시하는 함수
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
