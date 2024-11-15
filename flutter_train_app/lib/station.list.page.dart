import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String stationType;

  StationListPage({super.key, required this.stationType});

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
    return Scaffold(
      appBar: AppBar(
        title: Text(stationType),
      ),
      body: ListView.separated(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stations[index],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context, stations[index]);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
      ),
    );
  }
}
