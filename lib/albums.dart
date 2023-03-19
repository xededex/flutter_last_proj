import 'package:flutter/material.dart';

class Albums extends StatelessWidget {
  const Albums({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Albums',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AlbumsPage(),
    );
  }
}

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final titles = ["Название 1", "Название 2", "Название 3"];
  final subtitles = [
    "Исполнитель 1",
    "Исполнитель 2",
    "Исполнитель 3"
  ];
  final icons = ['res/albums-icon.png', 'res/albums-icon.png', 'res/albums-icon.png'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 3,
              itemBuilder: (context, index){
                return Card(
                    child: ListTile(
                      title: Text(titles[index]),
                      subtitle: Text(subtitles[index]),
                      leading: Image(image: AssetImage(icons[index])),
                      onTap: ()=>{
                        //Navigation.push()
                      },
                    )
                );
              },
        )),
      ),
    );
  }
}
