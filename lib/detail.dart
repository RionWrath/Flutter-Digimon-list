import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digimon App',
      home: DigimonList(),
    );
  }
}

class DigimonList extends StatefulWidget {
  @override
  _DigimonListState createState() => _DigimonListState();
}

class _DigimonListState extends State<DigimonList> {
  ApiService apiService = ApiService();
  late Future<List<Map<String, dynamic>>> digimonData;

  @override
  void initState() {
    super.initState();
    digimonData = apiService.getDigimonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digimon List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: digimonData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> digimonList = snapshot.data ?? [];

            return ListView.builder(
              itemCount: digimonList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(digimonList[index]['name'] ?? ''),
                    subtitle: Text('Level: ${digimonList[index]['level'] ?? ''}'),
                    leading: Image.network(
                      digimonList[index]['img'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
