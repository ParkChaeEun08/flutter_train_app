import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  // 출발역, 도착역 타입이랑 선택된 역 제외
  final String stationType;
  final String exclusion;

//생성자 stationType이랑 exclusion을 받아옴
  StationListPage(
      {super.key, required this.stationType, required this.exclusion});

//역 리스트
  final List<String> stations = [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산'
  ];

  @override
  Widget build(BuildContext context) {
    // exclusion을 제외한 역 리스트 생성
    List<String> filteredStations =
        stations.where((station) => station != exclusion).toList();

    return Scaffold(
      appBar: AppBar(
        // 상단 바의 제목을 stationType(출발역 또는 도착역)으로 설정
        title: Text(stationType),
      ),
      // 필터링된 역 리스트를 보여주는 ListView를 생성
      body: ListView.separated(
        // 필터링된 역 리스트의 개수를 항목 수로 설정
        itemCount: filteredStations.length,
        // 각 항목에 대해 ListTile 위젯을 생성
        itemBuilder: (context, index) {
          return ListTile(
            // 필터링된 역 이름을 텍스트로 표시
            title: Text(filteredStations[index],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // 항목을 탭하면 Navigator.pop을 사용해 선택한 역을 반환
            onTap: () {
              Navigator.pop(context, filteredStations[index]);
            },
          );
        },
        // 항목 사이에 Divider을 추가
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
      ),
    );
  }
}
