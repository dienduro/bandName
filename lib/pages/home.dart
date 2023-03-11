import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sokect1/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Heroes del Silencio', votes: 5),
    Band(id: '3', name: 'Qeen', votes: 5),
    Band(id: '4', name: 'Guns&Roses', votes: 6),
  ];
  void addBandToList(String name) {
    if (name.isNotEmpty) {
      //agregamos si el campo no viene vacio
      bands.add(
        Band(id: DateTime.now().toString(), name: name, votes: 1),
      );
      setState(() {});

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: _addNewBand,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          'BandName',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) {
          return _bandTile(bands[index]);
        },
      ),
    );
  }

  _addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5,
              textColor: Colors.blue,
              child: const Text('Add'),
              onPressed: () {
                addBandToList(textController.text);
              },
            )
          ],
          title: const Text('data'),
        ),
      );
    }

    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('New band name:'),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Add'),
            onPressed: () => addBandToList(textController.text),
          ),
          CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Dismiss'),
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }

  Widget _bandTile(Band bands) {
    return Dismissible(
      onDismissed: (direction) {
        //TODO: llamar el borrador en el servidor
        print('direction: $direction');
        setState(() {});
      },
      key: Key(bands.id),
      direction: DismissDirection.startToEnd,
      child: ListTile(
        onTap: () {},
        trailing: Text(
          '${bands.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        title: Text(bands.name),
        leading: CircleAvatar(
          child: Text(bands.name.substring(0, 2)),
        ),
      ),
    );
  }
}
