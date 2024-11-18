import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String stationType;
  final String exclusion;

  StationListPage(
      {super.key, required this.stationType, required this.exclusion});

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
    List<String> filteredStations =
        stations.where((station) => station != exclusion).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(stationType),
      ),
      body: ListView.separated(
        itemCount: filteredStations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredStations[index],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context, filteredStations[index]);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
      ),
    );
  }
}
