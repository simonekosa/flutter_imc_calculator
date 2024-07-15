import 'package:flutter/material.dart';
import 'componentes/custom_app_bar.dart'; // Importando o CustomAppBar

class ResultScreen extends StatefulWidget {
  final List<String> results;

  ResultScreen({required this.results});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late List<String> _results;

  @override
  void initState() {
    super.initState();
    _results = widget.results;
  }

  void _deleteResult(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Você tem certeza que deseja excluir este item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _results.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Deletar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Resultados'), // Usando o CustomAppBar
      body: ListView.separated(
        itemCount: _results.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_results[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              _deleteResult(index);
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(_results[index]),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
      ),
    );
  }
}
