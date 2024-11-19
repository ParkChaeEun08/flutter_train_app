import 'package:flutter/material.dart';

class StationListPage extends StatefulWidget {
  // 출발역, 도착역 타입이랑 선택된 역 제외
  final String stationType;
  final String exclusion;

//생성자 stationType이랑 exclusion을 받아옴
  StationListPage(
      {super.key, required this.stationType, required this.exclusion});

  @override
  _StationListPageState createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage>
    with SingleTickerProviderStateMixin {
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

  List<String> favoriteStations = []; // 즐겨찾기 리스트
  List<String> filteredStations = []; // 검색된 역 리스트
  TextEditingController searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // exclusion을 제외한 초기 역 리스트 생성
    filteredStations =
        stations.where((station) => station != widget.exclusion).toList();
    searchController.addListener(_filterStations);
    // TabController 초기화
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 상단 바의 제목을 stationType(출발역 또는 도착역)으로 설정
        title: Text(widget.stationType),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(96.0),
          child: Column(
            children: [
              // TabBar를 사용하여 "모든 역"과 "즐겨찾기" 탭 생성
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: '모든 역'),
                  Tab(text: '즐겨찾기'),
                ],
              ),
              // 역 검색 기능을 위한 TextField 추가
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: '역 검색',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 모든 역 리스트와 즐겨찾기 리스트를 각각 Tab에 표시
          _buildStationList(filteredStations),
          _buildStationList(favoriteStations),
        ],
      ),
    );
  }

  // 검색 텍스트를 기반으로 역 리스트를 필터링하는 함수
  void _filterStations() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredStations = stations.where((station) {
        return station != widget.exclusion &&
            station.toLowerCase().contains(query);
      }).toList();
    });
  }

  // 역 리스트를 빌드하는 함수
  Widget _buildStationList(List<String> stations) {
    return ListView.separated(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        bool isFavorite = favoriteStations.contains(stations[index]);
        return ListTile(
          title: Text(stations[index],
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.yellow : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  // 즐겨찾기에서 역 제거
                  favoriteStations.remove(stations[index]);
                } else {
                  // 즐겨찾기에 역 추가
                  favoriteStations.add(stations[index]);
                }
              });
            },
          ),
          // 항목을 탭하면 Navigator.pop을 사용해 선택한 역을 반환
          onTap: () {
            Navigator.pop(context, stations[index]);
          },
        );
      },
      // 항목 사이에 Divider을 추가
      separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
    );
  }
}
