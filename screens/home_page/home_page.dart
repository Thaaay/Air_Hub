import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> posts = [];
  User? user = FirebaseAuth.instance.currentUser; // <- declare aqui

  Future<void> _addPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        posts.insert(0, File(pickedFile.path));
      });
    }
  }

  Widget buildSidebar() {
    return Container(
      width: 250,
      color: Colors.blueGrey[900],
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(height: 20),
          Text(
            user?.displayName ?? 'Usuário', // agora funciona
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            user?.email ?? 'Sem email', // agora funciona
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget buildFeed() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _addPhoto,
            icon: Icon(Icons.add_a_photo),
            label: Text('Adicionar Foto'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text('Nova postagem', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),
                        Image.file(posts[index]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isWideScreen = constraints.maxWidth > 600;

      return Scaffold(
        appBar: isWideScreen
            ? null
            : AppBar(title: Text('Feed de Notícias')),
        drawer: isWideScreen ? null : Drawer(child: buildSidebar()),
        body: isWideScreen
            ? Row(
          children: [
            buildSidebar(),
            Expanded(child: buildFeed()),
          ],
        )
            : buildFeed(),
      );
    });
  }
}
